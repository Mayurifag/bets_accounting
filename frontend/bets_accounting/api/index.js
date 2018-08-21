import axios from "axios";

export default {
  fetchBets() {
    return axios.get("/api/bets");
  },
  deleteBet(betId) {
    return axios.delete(`/api/bets/${betId}`);
  }
};
