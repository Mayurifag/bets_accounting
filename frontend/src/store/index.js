import Vue from 'vue';
import Vuex from 'vuex';
import api from '../api';

Vue.use(Vuex);

export default new Vuex.Store({
  strict: true,
  state: {
    bets: [],
    token: localStorage.getItem('token') || '',
  },
  actions: {
    fetchBets({ commit }) {
      return new Promise((resolve, reject) => {
        api
          .fetchBets()
          .then((response) => {
            commit('SET_BETS', response.data);
            resolve(response);
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
    login({ commit }, user) {
      return new Promise((resolve, reject) => {
        api
          .auth(user.email, user.password)
          .then((response) => {
            commit('SET_USER', response.data);
            resolve(response);
          })
          .catch((error) => {
            localStorage.removeItem('token')
            reject(error);
          });
      });
    }
  },
  /* eslint-disable no-param-reassign */
  mutations: {
    SET_BETS(state, bets) {
      state.bets = bets;
    },
    SET_USER(state, response) {
      localStorage.setItem('token', response.jwt);
      state.token = response.jwt
    }
  },
  getters: {
    bets: state => state.bets,
    isLoggedIn: state => !!state.token,
  },
});
