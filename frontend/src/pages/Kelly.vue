<template lang="pug">
#kelly.card.card-content
  .media
    .media-left
      figure.image.is-48x48
        img(src="../static/placeholder-96x96.png" alt="Kelly")
    .media-content
      p.title.is-4 Расчет критерия Келли
      //- TODO: need a better link I guess..
      a(href='https://www.wikiwand.com/en/Kelly_criterion') wiki

  .content
    b-field(label="Текущий банк")
      b-input.small-field(v-model="bank" placeholder=10000)

    b-field(label="Коэффицент букмекерской конторы")
      b-input.small-field(v-model="bookmaker_coefficent" autofocus placeholder="1.95")

    b-field(label="Прогноз игрока")
      <!-- workaround for https://github.com/buefy/buefy/issues/87 -->
      b-field.small-field
        b-input(v-model="player_prediction" expanded placeholder="57")
        p.control
          span.button.is-static %

    .result(v-show="kelly_percent != null")
      p Процент от ставки:
        strong  {{ kelly_percent_formatted }}
      p Рекомендуемый размер ставки:
        strong  {{ kelly_result }}
</template>

<script>
export default {
  data() {
    return {
      bank: 10000,
      bookmaker_coefficent: 1.93,
      player_prediction: 67,
    };
  },

  computed: {
    kelly_percent() {
      const percent = ((this.player_prediction / 100) * this.bookmaker_coefficent - 1)
        / (this.bookmaker_coefficent - 1);
      if (Number.isFinite(percent)) {
        return percent.toFixed(6);
      }
      return null;
    },
    kelly_percent_formatted() {
      return `${(this.kelly_percent * 100).toFixed(2)}%`;
    },
    kelly_result() {
      const result = this.kelly_percent * this.bank;
      return result.toFixed(2);
    },
  },
};
</script>

<style scoped lang="scss">
.small-field {
  width: 80px;
}

.title {
  margin-bottom: 0;
}
</style>
