/*
 * Desc: 构建镇派数据
 * Author : iRuxu
 * Email : rx6@qq.com
 * Time :
 */
const fs = require("fs");
const path = require("path");
const dateFormat = require("./includes/dateFormat");
const filter = require("./includes/filter.js");
const { Logger, readTabFile, buildProgressBar } = require("./includes/utils");

const dist = "../output";

(async () => {
    Logger.info("========== 开始构建镇派数据 ==========");
    Logger.info("读取必要的raw数据......");
    const datas = {
        raw: require("../raw/talent.json"),
        xf: require("@jx3box/jx3box-data/data/xf/xf.json"),
        talent_relation: require("../raw/talent_ralation.json"),
        talent_pretab: require("../raw/talent_pretab.json"),
        skill: [],
        skill_txt: (await readTabFile(path.join(__dirname, "../raw/skill.txt"))).reduce((acc, cur) => {
            let key = `${cur.SkillID}_${cur.Level}`;
            acc[key] = cur;
            return acc;
        }, {}),
        skill_tab: (await readTabFile(path.join(__dirname, "../raw/skills.tab"))).reduce((acc, cur) => {
            acc[cur.SkillID] = cur;
            return acc;
        }, {}),
        buff: [],
        buff_txt: (await readTabFile(path.join(__dirname, "../raw/buff.txt"))).reduce((acc, cur) => {
            let key = `${cur.BuffID}_${cur.Level}`;
            acc[key] = cur;
            return acc;
        }, {}),
        buff_tab: (await readTabFile(path.join(__dirname, "../raw/buff.tab"))).reduce((acc, cur) => {
            let key = `${cur.ID}_${cur.Level}`;
            cur.BuffID = cur.ID;
            cur.BuffName = cur.Name;
            delete cur.ID;
            delete cur.Name;
            acc[key] = cur;
            return acc;
        }, {}),
        output: {},
        talent2: {},
    };
    Logger.info("合并需要用到的 skill 数据......");
    {
        let bar = await buildProgressBar(Object.keys(datas.skill_txt).length, "合并需要用到的 skill 数据");
        for (let k in datas.skill_txt) {
            let skill = datas.skill_txt[k];
            let _skill = datas.skill_tab[skill.SkillID];
            if (!_skill) _skill = {};
            skill = Object.assign(skill, _skill);
            _skill.__scan = true;
            datas.skill.push(skill);
            bar.tick();
        }
        let remain_skills = Object.values(datas.skill_tab).filter((t) => !t.__scan);
        bar.total = bar.total + remain_skills.length;
        for (let skill of remain_skills) {
            datas.skill.push(skill);
            bar.tick();
        }
        bar.terminate();
    }
    Logger.info("合并需要用到的 buff 数据.....");
    {
        bar = await buildProgressBar(Object.keys(datas.buff_tab).length, "buff合表中...", "...");
        for (let buffid in datas.buff_tab) {
            let buff = datas.buff_tab[buffid];
            let _buff = datas.buff_txt[`${buff.BuffID}_${buff.Level}`];
            if (!_buff) _buff = {};
            buff = Object.assign(buff, _buff);
            _buff.__scan = true;
            datas.buff.push(buff);
            bar.tick();
        }
        let remain_buff = Object.values(datas.buff_txt).filter((buff) => !buff.__scan);
        bar.total = bar.total + remain_buff.length;
        for (let buff of remain_buff) {
            datas.buff.push(buff);
            bar.tick();
        }
        bar.terminate();
        Logger.info("构建镇派数据......");
    }
    //需要用到的方法
    const getSkill = (id) => {
        if (!id) return null;
        let res = datas.skill.filter((t) => t.SkillID == id);
        const length = res.length;
        if (!length) return null;
        let max = ~~res[length - 1]["MaxLevel"];
        const _item = res.find((l) => l.Level == 1); // 图标获取技能等级为1的数据
        let item = _item || res[max - 1];
        // let max = Math.max(length - 1, 1);    //层数
        let desc;

        if (length > 1) {
            const first = res[0];
            const skillList = parseInt(first.Level) ? res : res.slice(1, length);
            desc = skillList.map((d) => d["Desc"]);
            desc = desc.map((d1) => filter(d1, datas));
            desc.map((d2) => d2 && d2.replace(/"/g, "'"));
        } else {
            desc = res[res.length - 1]["Desc"];
            desc = filter(desc, datas); //过滤后的奇穴描述
            desc = desc.replace(/"/g, "'"); //奇穴内容的"规范为单引号
            desc = [desc];
        }
        return {
            id: id,
            name: item.Name,
            icon: ~~item.IconID,
            desc: desc,
            // type: item.SpecialDesc ? "skill" : "talent",
            type: !!~~item.IsPassiveSkill ? "talent" : "skill",
            children: [], //已废弃
            pretab: datas.talent_pretab[id] || "",
            max: max,
        };
    };
    bar = await buildProgressBar(Object.keys(datas.raw).length * 6 * 4, "构建镇派数据");
    for (let xf_name in datas.raw) {
        // 固定6行，每行4个
        datas.output[datas.talent_relation[xf_name]] = [];
        const xf_talent = datas.output[datas.talent_relation[xf_name]];
        const xf_raw = datas.raw[xf_name];
        // 每一行
        for (let row in xf_raw) {
            xf_talent.push([]);
            const row_data = xf_raw[row];
            for (let col in row_data) {
                const skill_id = row_data[col];
                const skill = getSkill(skill_id);
                if(!skill && skill_id) {
                    bar.clear();
                    Logger.warn(`心法 ${xf_name} 的第 ${~~row + 1} 行第 ${~~col + 1} 列的镇派技能 ID ${skill_id} 不存在`);
                }
                xf_talent[row][col] = skill;
                bar.tick();
            }
        }
    }
    bar.terminate();
    Logger.success("镇派构建结束，进行 renderBpsTalent2 ......");
    for (let talent in datas.raw) {
        let mountID = datas.xf[talent]["id"];
        datas.talent2[mountID] = datas.raw[talent].map((item) => item.filter((t) => t));
    }
    Logger.success("renderBpsTalent2 结束，输出结果");
    fs.writeFileSync(path.join(__dirname, dist, `/v${dateFormat(new Date())}.json`), JSON.stringify(datas.output));
    fs.writeFileSync(path.join(__dirname, dist, `/talent2.json`), JSON.stringify(datas.talent2));
    fs.writeFileSync(path.join(__dirname, `../src/data/talent2.json`), JSON.stringify(datas.talent2));
    Logger.success("结果已输出，脚本运行结束");
})();
