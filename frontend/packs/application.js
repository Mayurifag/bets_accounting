import Vue from "vue";
import Home from "./components/home.vue";

document.addEventListener("DOMContentLoaded", () => {
  const el = document.body.appendChild(document.createElement("application"));
  const app = new Vue({
    el,
    render: h => h(Home)
  });

  console.log(app);
});
