import Vue from "vue";
import Vuex from "vuex";
import api from "../api";

Vue.use(Vuex);

export default new Vuex.Store({
  strict: true,
  state: {
    bets: []
  },
  actions: {
    // fetchBets({ commit, state }) {
    fetchBets({ commit }) {
      return new Promise((resolve, reject) => {
        api
          .fetchBets()
          .then(response => {
            commit("SET_BETS", response.data);
            resolve();
          })
          .catch(error => {
            reject(error);
          });
      });
    }
  },
  /* eslint-disable no-param-reassign */
  mutations: {
    SET_BETS(state, bets) {
      state.bets = bets;
    }
  },
  getters: {
    // bets(state, getters) {
    bets(state) {
      return state.bets;
    }
  }
});
