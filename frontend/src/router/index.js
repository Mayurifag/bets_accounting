import Vue from 'vue';
import VueRouter from 'vue-router';
import store from '../store';

const Kelly = () => import(/* webpackChunkName: "group-kelly" */ '../pages/Kelly.vue');
const BetsList = () => import(/* webpackChunkName: "group-betslist" */ '../pages/BetsList.vue');
const Login = () => import(/* webpackChunkName: "group-login" */ '../pages/Login.vue');

Vue.use(VueRouter);

const routes = [
  { path: '/', component: Kelly },
  { path: '/bets', component: BetsList, props: true },
  // { path: '/bets', component: BetsList, props: true, meta: { requiresAuth: true } },
  { path: '/login', component: Login },
  // TODO: vue-error-page?
  { path: '*', component: Login },
];

const router = new VueRouter({
  routes,
  mode: 'history',
  linkExactActiveClass: 'is-active',
  linkActiveClass: 'is-active',
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (store.getters.isLoggedIn) {
      next();
      return;
    }
    next('/login');
  } else {
    next();
  }
});

export default router;
