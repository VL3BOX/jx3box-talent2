<template>
    <render-talent :talent-code="code"></render-talent>
</template>

<script>
import renderTalent from "./RenderTalent2.vue"
export default {
    name: 'Talent2Plugin',
    data() {
        return {
            code: ''
        }
    },
    methods: {
        /**
         * 对加密后的镇派编码进行解码
         * @param {string} val 加密后的编码
         * @returns {string} 解码后的数据
         */
        decodeCode: function(val) {
            return decodeURIComponent(escape(window.atob(val)));
        },
        init: function() {
            const regex = new RegExp(/code=(.*)/g);

            const code = document.location.href.match(regex);

            const _code = code && code.join('').slice(5);

            this.code = this.decodeCode(_code)
        }
    },
    created: function() {
        this.init()
    },
    components: {
        renderTalent
    }
}
</script>