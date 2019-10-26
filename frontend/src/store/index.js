import Vue from 'vue';
import Vuex from 'vuex';
import api from '../api';
import axios from 'axios';

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
            localStorage.setItem('token', response.data.jwt);
            resolve(response);
          })
          .catch((error) => {
            localStorage.removeItem('token')
            reject(error);
          });
      });
    },
    logout({ commit }) {
      return new Promise((resolve) => {
        commit('LOGOUT');
        delete axios.defaults.headers.common['Authorization'];
        localStorage.removeItem('token');
        resolve();
      })
    }
  },

  mutations: {
    SET_BETS(state, bets) {
      state.bets = bets;
    },
    SET_USER(state, response) {
      state.token = response.jwt;
    },
    LOGOUT(state) {
      state.token = '';
    }
  },

  getters: {
    bets: state => state.bets,
    isLoggedIn: state => !!state.token,
  },
});
