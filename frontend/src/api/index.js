import Vue from 'vue';
import axios from 'axios';

// TODO: Env port for backend
axios.defaults.baseURL = 'http://localhost:8888';

Vue.prototype.$http = axios;
const token = localStorage.getItem('token');

if (token) {
  Vue.prototype.$http.defaults.headers.common.Authorization = token;
}

export default {
  // CRUD Bets
  fetchBets(params = '') {
    return axios.get(`/api/bets${params}`);
  },
  saveBet(bet) {
    return bet && bet.id ? this.updateBet(bet) : this.createBet(bet);
  },
  deleteBet(betId) {
    return axios.delete(`/api/bets/${betId}`);
  },
  updateBet(bet) {
    return axios.put(`/api/bets/${bet.id}`, { bet });
  },
  createBet(bet) {
    return axios.post('/api/bets', { bet });
  },

  // Autocomplete
  autocomplete(className, autocomplete) {
    return axios.post('/api/autocomplete', {
      class_name: className,
      query: autocomplete,
    });
  },

  // Users
  auth(email, password) {
    return axios.post('/api/auth', {
      email,
      password,
    });
  },
  register(email, password, passwordConfirmation) {
    return axios.post('/api/users', {
      email,
      password,
      password_confirmation: passwordConfirmation,
    });
  },
};
