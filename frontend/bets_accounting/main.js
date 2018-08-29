import Vue from "vue";

import VueProgressBar from "vue-progressbar";
import VeeValidate from "vee-validate";

import Buefy from "buefy";
import "buefy/lib/buefy.css";

import { sync } from "vuex-router-sync";
import router from "./router";
import store from "./store";

import App from "./app.vue";

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
      render: h => h(App)
    });
  }
});
