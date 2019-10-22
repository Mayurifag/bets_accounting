<template lang="pug">
#bets_accounting
  vue-progress-bar

  nav.navbar.is-primary.is-sticky.containter
    .navbar-brand
      router-link(to="/" exact).navbar-item
        img(src="./static/logo.png" alt="Logo")
      .navbar-burger.burger(@click="isNavbarActive = !isNavbarActive" :class="isNavbarActive ? 'is-active' : ''")
        span
        span
        span

    .navbar-menu(:class="isNavbarActive ? 'is-active' : ''" @click="isNavbarActive = !isNavbarActive")
      .navbar-start
        router-link(to="/" exact).navbar-item Келли
        router-link(to="/bets" exact).navbar-item Демо
      .navbar-end
        router-link(to="/login" exact).navbar-item Login
        //- .navbar-item balance [todo]
        //- .navbar-item About page [todo]
  router-view(:key="$route.fullPath")
</template>

<script>
import { mapState } from 'vuex';

export default {
  data() {
    return {
      isNavbarActive: false,
    };
  },

  created() {
    // $Progress for vue-progressbar
    this.$Progress.start();

    this.$store.dispatch('fetchBets').then(() => {
      this.$Progress.finish();
    });

    this.$router.beforeEach((to, from, next) => {
      if (to.meta.progress !== undefined) {
        const meta = to.meta.progress;
        this.$Progress.parseMeta(meta);
      }
      this.$Progress.start();
      next();
    });

    this.$router.afterEach((to, from) => {
      this.$Progress.finish();
    });
  },

  computed: {
    ...mapState(['bets'])
  },
};
</script>
