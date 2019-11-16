import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import api from '../api';

Vue.use(Vuex);

export default new Vuex.Store({
  strict: true,

  state: {
    bets: [],
    token: localStorage.getItem('token') || '',
    total_bets: 0,
    bets_page: 1,
    bets_perPage: 25,
  },

  actions: {
    fetchBets({ commit }) {
      return new Promise((resolve, reject) => {
        const params = `?page=${this.state.bets_page}`;
        api
          .fetchBets(params)
          .then((response) => {
            commit('SET_BETS', response.data);
            resolve(response);
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
    setBetsPage({ commit }, page) {
      commit('SET_BETS_PAGE_NUMBER', page);
    },
    login({ commit }, user) {
      return new Promise((resolve, reject) => {
        api
          .auth(user.email, user.password)
          .then((response) => {
            commit('SET_USER', response.data);
            axios.defaults.headers.common.Authorization = response.data.jwt;
            localStorage.setItem('token', response.data.jwt);
            resolve(response);
          })
          .catch((error) => {
            localStorage.removeItem('token');
            reject(error);
          });
      });
    },
    register({ dispatch }, user) {
      return new Promise((resolve, reject) => {
        api
          .register(user.email, user.password, user.password_confirmation)
          .then((response) => {
            dispatch('login', user, { root: true });
            resolve(response);
          })
          .catch((error) => {
            localStorage.removeItem('token');
            reject(error);
          });
      });
    },
    logout({ commit }) {
      return new Promise((resolve) => {
        commit('LOGOUT');
        delete axios.defaults.headers.common.Authorization;
        localStorage.removeItem('token');
        resolve();
      });
    },
  },

  mutations: {
    SET_BETS(state, payload) {
      state.total_bets = payload.pagy.count;
      state.bets_perPage = payload.pagy.vars.items;
      state.bets_page = payload.pagy.page;
      state.bets = payload.records;
    },
    SET_USER(state, response) {
      state.token = response.jwt;
    },
    LOGOUT(state) {
      state.token = '';
    },
    SET_BETS_PAGE_NUMBER(state, number) {
      state.bets_page = number;
    },
  },

  getters: {
    bets: (state) => state.bets,
    isLoggedIn: (state) => !!state.token,
    bets_page: (state) => state.bets_page,
    total_bets: (state) => state.total_bets,
    bets_perPage: (state) => state.bets_perPage,
  },
});
