import Vue from 'vue';
import VueRouter from 'vue-router';

import Kelly from '../pages/Kelly.vue';
import BetsList from '../pages/BetsList.vue';
import Login from '../pages/Login.vue'

Vue.use(VueRouter);

const routes = [
  { path: '/', component: Kelly },
  { path: '/bets', component: BetsList, props: true },
  { path: '/login', component: Login },
  // TODO: vue-error-page?
  { path: '*', component: Kelly },
];

export default new VueRouter({
  routes,
  mode: 'history',
  linkExactActiveClass: 'is-active',
  linkActiveClass: 'is-active',
});
