import Vue from 'vue';

import { sync } from 'vuex-router-sync';

// import VueProgressBar from "vue-progressbar";
// TODO: upgrade to v.3 :: change to vuelidate
// import VeeValidate from "vee-validate";
// Vue.use(VueProgressBar);
// Vue.use(VeeValidate);

import Field from 'buefy/dist/components/field'; // b-field
import Icon from 'buefy/dist/components/icon'; // b-icon
import Input from 'buefy/dist/components/input'; // b-input

// import 'buefy/dist/buefy.css';

import store from './store/index';
import router from './router/index';

import App from './App.vue';

Vue.use(Field);
Vue.use(Icon);
Vue.use(Input);

sync(store, router);

Vue.config.productionTip = false;

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(
    document.createElement('bets_accounting'),
  );

  if (el !== null) {
    new Vue({ // eslint-disable-line no-new
      el,
      router,
      store,
      render: h => h(App),
    });
  }
});
