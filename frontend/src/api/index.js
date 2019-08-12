import axios from 'axios';

// Rails arguing for csrf :S
// axios.defaults.headers.common['X-CSRF-Token'] = document
//   .querySelector('meta[name="csrf-token"]')
//   .getAttribute('content');

// TODO: Env port for backend
var port = 8888;
axios.defaults.baseURL = location.protocol + '//' + location.hostname + ':' + port;

export default {
  // CRUD Bets:
  fetchBets() {
    return axios.get('/api/bets');
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
  // Autocomplete:
  autocompleteParticipants(participant) {
    return axios.get(`/api/bets?autocomplete_participants=${participant}`);
  },
  autocompleteDisciplines(discipline) {
    return axios.get(`/api/bets?autocomplete_disciplines=${discipline}`);
  },
};
