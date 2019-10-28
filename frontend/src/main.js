/* eslint-disable */
import Vue from "vue";

import VueProgressBar from "vue-progressbar";
// TODO: upgrade to v.3
import VeeValidate from "vee-validate";

// TODO: Individual components as Vue plugins
import Buefy from "buefy";
import "buefy/dist/buefy.css";

import { sync } from "vuex-router-sync";
import router from "./router/index.js";
import store from "./store/index.js";

import App from "./App.vue";

sync(store, router);

Vue.use(Buefy);
Vue.use(VueProgressBar);
Vue.use(VeeValidate);

Vue.config.productionTip = false;

document.addEventListener("DOMContentLoaded", () => {
  const el = document.body.appendChild(
    document.createElement("bets_accounting")
  );

  if (el !== null) {
    /* eslint-disable no-new */
    new Vue({
      el,
      router,
      store,
      render: h => h(App),
    });
  }
});
