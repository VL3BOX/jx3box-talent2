<template>
    <div class="c-talent2-box c-talent2-render-box" :class="{ 'webview': webview }">
        <div class="c-talent2-header">
            <h3 class="c-talent2-title">镇派模拟器</h3>
        </div>
        <template v-if="xf">
            <div class="c-talent2-main">
                <!-- LEFT -->
                <div class="c-talent2-left">
                    <div
                        class="c-talent2-content"
                        :style="{
                            'background-image': xf ? `url(${talentBg('left', 1)})` : ''
                        }"
                        :class="{ 'is-single': isSingle }"
                    >
                        <div class="c-talent2-group">
                            <img class="c-talent2-group-icon" :src="xfContent[0] | xficon" />
                            <span class="c-talent2-group-count">{{ lCount }}</span>
                            <span class="c-talent2-group-name">{{ l_name }}</span>
                        </div>
                        <div
                            class="c-talent2-content-row"
                            v-for="(row, index) in talentContent.left"
                            :key="'l'+index"
                        >
                            <template v-for="(item, i) in row">
                                <div
                                    v-if="item"
                                    class="c-talent2-content-item"
                                    :class="[
                                        {'c-talent2-content-item-skill': item.type === 'skill'},
                                        !canOperate(index, 'left') ? 'c-talent2-content-item-disabled' : '',
                                        item.pretab ? 'c-talent2-pretab' : ''
                                    ]"
                                    :key="i"
                                    @mouseover="$set(item, 'on', true)"
                                    @mouseleave="$set(item, 'on', false)"
                                >
                                    <div
                                        :class="[
                                            !canLeftItemOperate(index, i) ?
                                                (item.type === 'skill' ? 'c-talent2-skill-unselected' : 'c-talent2-unselected')
                                                    : 'c-talent2-selected',
                                            item.type === 'skill' ? '' : 'c-talent2-talent',
                                            !surplus && !Number(l_data[index][i]) ?
                                                (item.type === 'skill' ? 'c-talent2-skill-unselected' : 'c-talent2-unselected') : ''
                                        ]"
                                    >
                                        <!-- HAS PARENT -->
                                        <span
                                            v-if="item.pretab && !isLeftParentAdd(index, i) && canLeftItemOperate(index, i)"
                                            :class="item.type === 'skill' ? 'is-add-skill' : 'is-add'"
                                        ></span>
                                        <!-- TOTAL ZERO -->
                                        <span
                                            v-if="!surplus && !Number(l_data[index][i])"
                                            :class="item.type === 'skill' ? 'is-add-skill' : 'is-add'"
                                        ></span>
                                        <img
                                            class="talent-img"
                                            :class="{ 'skill-img': item.type === 'skill' }"
                                            :src="iconLink(item.icon)"
                                            :alt="item.name"
                                        />
                                    </div>
                                    <!-- DESC -->
                                    <span class="c-talent2-pop" :class="item.on ? 'on' : ''">
                                        <b class="c-talent2-name">
                                            <span>{{ item.name }}
                                                <small class="u-talent2-id" v-if="item.id">(ID: {{ item.id }})</small>
                                            </span>
                                            <span class="c-talent2-number">
                                                第{{ Number(l_data[index][i]) + '/' + item.max }}重
                                            </span>
                                        </b>
                                        <!-- <b class="c-talent2-type">
                                            {{ item.type === 'talent' ? '被动招式': '主动招式' }}
                                        </b>-->
                                        <span class="c-talent2-desc">
                                            {{ !Number(l_data[index][i]) || xf === '通用'
                                            ? item.desc[0]
                                            : item.desc[l_data[index][i] - 1]
                                            }}
                                        </span>
                                        <span
                                            v-if="Number(l_data[index][i]) && Number(l_data[index][i]) < item.max"
                                            class="c-talent2-desc-next"
                                        >
                                            <span v-if="xf !== '通用'" class="c-next-text">下一重：</span>
                                            <span>
                                                {{
                                                item.desc[l_data[index][i]]
                                                }}
                                            </span>
                                        </span>
                                        <span
                                            v-if="Number(l_data[index][i]) === item.max"
                                            class="c-talent2-pop-max"
                                        >该招式已练至最高境界</span>
                                    </span>
                                    <!-- COUNT -->
                                    <span
                                        v-if="Number(l_data[index][i])"
                                        class="c-talent2-content-item-count"
                                    >{{ l_data[index][i] }}</span>
                                </div>
                                <div v-else class="c-talent2-content-item-empty" :key="i + 'empty'"></div>
                            </template>
                        </div>
                    </div>
                </div>

                <!-- RIGHT -->
                <div class="c-talent2-right" v-if="!isSingle">
                    <div
                        class="c-talent2-content"
                        :style="{
                            'background-image': xf ? `url(${talentBg('right', 1)})` : ''
                        }"
                    >
                        <div class="c-talent2-group">
                            <img class="c-talent2-group-icon" :src="xfContent[1] | xficon" />
                            <span class="c-talent2-group-count">{{ rCount }}</span>
                            <span class="c-talent2-group-name">{{ r_name }}</span>
                        </div>
                        <div
                            class="c-talent2-content-row"
                            v-for="(row, index) in talentContent.right"
                            :key="'l'+index"
                        >
                            <template v-for="(item, i) in row">
                                <div
                                    v-if="item"
                                    class="c-talent2-content-item"
                                    :class="[
                                        {'c-talent2-content-item-skill': item.type === 'skill'},
                                        !canOperate(index, 'right') ? 'c-talent2-content-item-disabled' : '',
                                        item.pretab ? 'c-talent2-pretab' : '',
                                    ]"
                                    :key="i"
                                    @mouseover="$set(item, 'on', true)"
                                    @mouseleave="$set(item, 'on', false)"
                                >
                                    <div
                                        :class="[
                                            !canRightItemOperate(index, i) ?
                                                (item.type === 'skill' ? 'c-talent2-skill-unselected' : 'c-talent2-unselected')
                                                    : 'c-talent2-selected',
                                            item.type === 'skill' ? '' : 'c-talent2-talent',
                                            !surplus && !Number(r_data[index][i]) ?
                                                (item.type === 'skill' ? 'c-talent2-skill-unselected' : 'c-talent2-unselected') : ''
                                        ]"
                                    >
                                        <!-- HAS PARENT -->
                                        <span
                                            v-if="item.pretab && !isRightParentAdd(index, i) && canRightItemOperate(index, i)"
                                            :class="item.type === 'skill' ? 'is-add-skill' : 'is-add'"
                                        ></span>
                                        <!-- TOTAL ZERO -->
                                        <span
                                            v-if="!surplus && !Number(r_data[index][i])"
                                            :class="item.type === 'skill' ? 'is-add-skill' : 'is-add'"
                                        ></span>
                                        <img
                                            class="talent-img"
                                            :class="{ 'skill-img': item.type === 'skill' }"
                                            :src="iconLink(item.icon)"
                                            :alt="item.name"
                                        />
                                    </div>
                                    <!-- DESC -->
                                    <span class="c-talent2-pop" :class="item.on ? 'on' : ''">
                                        <b class="c-talent2-name">
                                            <span>{{ item.name }}
                                                <small class="u-talent2-id" v-if="item.id">(ID: {{ item.id }})</small>
                                            </span>
                                            <span class="c-talent2-number">
                                                第{{ Number(r_data[index][i]) + '/' + item.max }}重
                                            </span>
                                        </b>
                                        <!-- <b class="c-talent2-type">
                                            {{ item.type === 'talent' ? '被动招式': '主动招式' }}
                                        </b>-->
                                        <span class="c-talent2-desc">
                                            {{ !Number(r_data[index][i]) || xf === '通用'
                                            ? item.desc[0]
                                            : item.desc[r_data[index][i] - 1]
                                            }}
                                        </span>
                                        <span
                                            v-if="Number(r_data[index][i]) && Number(r_data[index][i]) < item.max"
                                            class="c-talent2-desc-next"
                                        >
                                            <span v-if="xf !== '通用'" class="c-next-text">下一重：</span>
                                            <span>
                                                {{
                                                item.desc[r_data[index][i]]
                                                }}
                                            </span>
                                        </span>
                                        <span
                                            v-if="Number(r_data[index][i]) === item.max"
                                            class="c-talent2-pop-max"
                                        >该招式已练至最高境界</span>
                                    </span>

                                    <!-- COUNT -->
                                    <span
                                        v-if="Number(r_data[index][i])"
                                        class="c-talent2-content-item-count"
                                    >{{ r_data[index][i] }}</span>
                                </div>
                                <div v-else class="c-talent2-content-item-empty" :key="i + 'empty'"></div>
                            </template>
                        </div>
                    </div>
                </div>
            </div>
        </template>
        <div class="c-talent2-footer" :class="{'is-single': isSingle}">
            <a href="https://www.jx3box.com/app/talent2" target="_blank">JX3BOX Talent2 v{{app_version}}</a>
        </div>
    </div>
</template>

<script>
import {
    __imgPath,
    __dataPath,
    __iconPath,
} from "@jx3box/jx3box-common/data/jx3box.json";
import { xfConfigs } from "./talent2.json";
import { defaultXf, defaultConfigs } from "./default.json";
import { iconLink } from "@jx3box/jx3box-common/js/utils";
import { version } from "../package.json";
export default {
    name: "RenderTalent2",
    props: {
        talentCode: {
            type: String,
            default: "",
        },
        webview: {
            type: Boolean,
            default: false,
        }
    },
    data: () => ({
        xf: "",
        begin: "",
        l_name: "斩绝",
        r_name: "封魂",

        version : '',
        talents: [], // 镇派数据
        total: 33,
        l_data: ["0000", "0000", "0000", "0000", "0000", "0000"],
        r_data: ["0000", "0000", "0000", "0000", "0000", "0000"],
        series_open_need: 26,

        // 心法字符串对应的心法id，用于左右背景
        xfContent: [],
        // 心法镇派或技能
        talentContent: {
            left: [],
            right: [],
        },

        parseCode: {},

        condition: [],
        mutex: [],

        // app version
        app_version : version
    }),
    computed: {
        // 是否为单心法
        isSingle: function () {
            return !this.talentContent.left || !this.talentContent.right;
        },
        lCount: function () {
            return this.l_data.length
                ? this.l_data
                      .map((l) => l.split(""))
                      .flat()
                      .reduce((prev, current) => Number(prev) + Number(current))
                : 0;
        },
        rCount: function () {
            return this.r_data.length
                ? this.r_data
                      .map((l) => l.split(""))
                      .flat()
                      .reduce((prev, current) => Number(prev) + Number(current))
                : 0;
        },
        totalCount: function () {
            return this.lCount + this.rCount;
        },
        surplus: function () {
            return this.total - this.totalCount;
        },
    },
    methods: {
        // 渲染镇派
        async renderTalents() {
            try {
                console.log(this.talentCode);
                this.parseCode = JSON.parse(this.talentCode);
                this.version = this.parseCode.version;
                await this.getTalents();
            } catch (e) {
                this.$message.error("编码格式错误");
            }
        },
        // talent 单项逻辑
        // -------------------
        /**
         * 判断该行是否可点
         * @param {number} rowIndex 行号
         * @param {string} target 左右区域
         * @returns {boolean} true表示可以编辑
         */
        canOperate: function (rowIndex, target) {
            if (target === "left") {
                return this.lCount >= this.condition[rowIndex];
            } else {
                return this.rCount >= this.condition[rowIndex];
            }
        },
        /**
         * 判断left该项父项是否加点
         */
        isLeftParentAdd: function (rowIndex, colIndex) {
            return Number(this.l_data[rowIndex - 1][colIndex]);
        },
        /**
         * 判断left该项是否可点
         * @param {number} rowIndex 行号
         * @param {number} index 列号
         * @param {string} target 左右区域
         * @returns {boolean} 是否可以修改
         */
        canLeftItemOperate: function (rowIndex, colIndex) {
            let canOperate = false;
            // 初始为left的第一行点亮
            if (this.begin === "left") {
                if (!rowIndex) {
                    canOperate = true;
                } else if (this.lCount > 0 && this.lCount >= this.condition[rowIndex]) {
                    canOperate = true;
                }
            } else if (this.begin === "right") {
                if (
                    this.rCount >= this.series_open_need &&
                    this.lCount >= 0 &&
                    this.lCount >= this.condition[rowIndex]
                ) {
                    canOperate = true;
                }
            }
            // 渲染的时候，已经点了的就是亮的
            if(this.l_data[rowIndex][colIndex] != '0'){
                canOperate = true;
            }
            return canOperate;
        },
        /**
         * 判断right该项父项是否加点
         */
        isRightParentAdd: function (rowIndex, colIndex) {
            return Number(this.r_data[rowIndex - 1][colIndex]);
        },
        /**
         * 判断right该项是否可点
         * @param {number} rowIndex 行号
         * @param {number} index 列号
         * @param {string} target 左右区域
         * @returns {boolean} 是否可以修改
         */
        canRightItemOperate: function (rowIndex, colIndex) {
            let canOperate = false;
            // 初始为left的第一行点亮
            if (this.begin === "right") {
                if (!rowIndex) {
                    canOperate = true;
                } else if (this.rCount > 0 && this.rCount >= this.condition[rowIndex]) {
                    canOperate = true;
                }
            } else if (this.begin === "left") {
                if (
                    this.lCount >= this.series_open_need &&
                    this.rCount >= 0 &&
                    this.rCount >= this.condition[rowIndex]
                ) {
                    canOperate = true;
                }
            }
            // 渲染的时候，已经点了的就是亮的
            if(this.r_data[rowIndex][colIndex] != '0'){
                canOperate = true;
            }
            return canOperate;
        },
        /**
         * 心法背景图片
         * @param {string} pos 位置信息
         * @param {number|string} num 图片编号
         */
        talentBg: function (pos, num) {
            if (!pos) return;
            if (pos === "left") {
                return (
                    __imgPath + `image/talent/${this.xfContent[0]}_${num}.png`
                );
            }
            return __imgPath + `image/talent/${this.xfContent[1]}_${num}.png`;
        },
        async getTalents() {
            fetch(__dataPath + "talent2/" + this.version + ".json")
                .then((res) => res.json())
                .then((response) => {
                    this.talents = { ...response, ...defaultXf };

                    this.xf = this.parseCode.xf;

                    const val = this.xf;
                    this.xfContent = xfConfigs[val]?.content;
                    this.begin = xfConfigs[val]?.begin;

                    const _sq = this.parseCode.sq.split(",");

                    // 新增pop显示控制
                    this.talentContent.left = this.talents[
                        xfConfigs[val].talent[0]
                    ]?.map((left) => {
                        const _left = left.map((l) => {
                            if (l) this.$set(l, "on", false);
                            return l;
                        });
                        return _left;
                    });
                    this.l_name = xfConfigs[val]?.talent[0];

                    this.talentContent.right = this.talents[
                        xfConfigs[val].talent[1]
                    ]?.map((right) => {
                        const _right = right.map((r) => {
                            if (r) this.$set(r, "on", false);
                            return r;
                        });
                        return _right;
                    });
                    this.r_name = xfConfigs[val]?.talent[1];

                    // const col_len = Math.max(...this.talentContent.left.map((l) => l.length));
                    const row_len = this.talentContent.left.length;

                    if (this.begin === "left") {
                        this.l_data = _sq.slice(0, row_len);
                        this.r_data = _sq.slice(row_len, _sq.length);
                    } else if (this.begin === "right") {
                        this.r_data = _sq.slice(0, row_len);
                        this.l_data = _sq.slice(row_len, _sq.length);
                    }

                    // 激活条件
                    this.condition = xfConfigs[val]?.condition || [0,5,10,15,20,25];
                    this.mutex = xfConfigs[val]?.mutex || [];

                    this.total = val === "通用" ? 66 : defaultConfigs.total;
                    this.series_open_need = defaultConfigs.series_open_need;
                });
        },
        iconLink: function (id){
            if (this.xf == '通用') return iconLink(id)
            return iconLink(id, 'origin');
        }
    },
    filters: {
        xficon: function (id) {
            return __imgPath + "image/xf/" + id + ".png";
        }
    },
    watch: {
        talentCode: {
            handler(val) {
                if (val) {
                    this.renderTalents();
                }
            },
            immediate: true,
        },
    },
};
</script>

<style lang="less">
@import "./talent2.less";
</style>
