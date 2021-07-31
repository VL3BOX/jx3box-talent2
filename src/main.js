Vue.config.productionTip = false;

// 第三方UI组件
import Vue from "vue";

import App from "./App.vue";

new Vue({
    render: h => h(App),
}).$mount("#app");

