import Vue from "vue";
import VueRouter from "vue-router";

import Kelly from "../components/kelly.vue";
import BetsList from "../pages/BetsList.vue";

Vue.use(VueRouter);

const routes = [
  { path: "/", component: Kelly },
  { path: "/bets", component: BetsList, props: true }
];

export default new VueRouter({
  routes,
  mode: "history",
  linkExactActiveClass: "is-active",
  linkActiveClass: "is-active"
});
