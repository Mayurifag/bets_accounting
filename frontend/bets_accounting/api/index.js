import axios from "axios";

export default {
  fetchBets() {
    return axios.get("/api/bets");
  }
};
