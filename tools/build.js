/*
* Desc: 构建镇派数据
* Author : iRuxu
* Email : rx6@qq.com
* Time :
*/
const fs = require("fs");
const axios = require("axios");
const dateFormat = require("./includes/dateFormat");
const filter = require("./includes/filter.js");
const talentRelation = require("../raw/talent_ralation.json");
const talentPretab = require("../raw/talent_pretab.json");
const xf = require('@jx3box/jx3box-data/data/xf/xf.json')

const raw = require("../raw/talent.json");
const url = "http://localhost:7002/skill/id/";
let output = {};
const dist = "./output";

async function run() {
    // 门派
    for (let k in raw) {
        console.log(k, "--------------------->");
        // 固定6行，每行4个
        output[talentRelation[k]] = [[], [], [], [], [], []];
        let list = raw[k];
        // 每一行
        for (let r = 0; r < list.length; r++) {
            let row = list[r];
            for (let i = 0; i < row.length; i++) {
                let item = row[i];
                output[talentRelation[k]][r][i] = await getSkill(item);
            }
        }
    }
}
// 获取技能信息
async function getSkill(id) {
    if (id) {
        let res = await axios.get(url + id, {
            params: {
                client: "origin",
            },
        });
        const length = res.data.list.length;
        let max = ~~(res.data.list[length - 1]['MaxLevel']);
        const _item = res.data.list.find(l => l.Level === 1); // 图标获取技能等级为1的数据
        let item = _item || res.data.list[max - 1];
        // let max = Math.max(length - 1, 1);    //层数
        let desc;

        if (length > 1) {

            const first = res.data.list[0];

            const skillList = first.Level ? res.data.list : res.data.list.slice(1, length);

            desc = skillList.map(d => d['Desc']);

            desc.forEach(async (d1, i) => {
                desc[i] = await filter(d1, 'origin');
            })

            desc.map(d2 => {
                return d2.replace(/"/g, "'");
            })
        } else {
            desc = res.data.list[res.data.list.length - 1]["Desc"];
            desc = await filter(desc, "origin"); //过滤后的奇穴描述
            desc = desc.replace(/"/g, "'"); //奇穴内容的"规范为单引号

            desc = [desc]
        }


        let skill = {
            id: id,
            name: item.Name,
            icon: item.IconID,
            desc: desc,
            // type: item.SpecialDesc ? "skill" : "talent",
            type: !!~~item.IsPassiveSkill ? "talent" : "skill",
            children: [],   //已废弃
            pretab : talentPretab[id] || '',
            max: max,
        };
        console.log(id, item.Name);
        return skill;
    } else {
        return null;
    }
}

run().then(() => {
    let json = JSON.stringify(output);
    fs.writeFileSync(`${dist}/v${dateFormat(new Date())}.json`, json);
});

function renderBpsTalent2() {
    const talent2 = {}

    for (const talent in raw) {
        const mountID = xf[talent]['id']
        talent2[mountID] = raw[talent].map(item => item.filter(t => t))
    }

    fs.writeFileSync(`./output/talent2.json`, JSON.stringify(talent2), 'utf-8')
}

renderBpsTalent2()
