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
    | Debug info: Logged in? {{ isLoggedIn }}
    b-field(
      label="Текущий банк"
      :type="errors.has('bank') ? 'is-danger' : ''"
      :message="errors.has('bank') ? 'Должно быть больше нуля' : ''"
      )

      b-input.small-field(
        data-vv-name="bank"
        v-model="bank"
        v-validate="'numeric|required|min_value:1'"
        placeholder=10000
        )

    b-field(
      label="Коэффицент букмекерской конторы"
      :type="errors.has('bookmaker_coefficent') ? 'is-danger' : ''"
      :message="errors.has('bookmaker_coefficent') ? 'Должно быть больше 1.00' : ''"
      )

      b-input.small-field(
        data-vv-name="bookmaker_coefficent"
        v-model="bookmaker_coefficent"
        v-validate="'required|min_value:1'"
        autofocus
        placeholder="1.95"
        )

    b-field(
      label="Прогноз игрока"
      :type="errors.has('player_prediction') ? 'is-danger' : ''"
      :message="errors.has('player_prediction') ? 'Должно быть от 1 до 100 в процентах' : ''"
      )

      <!-- workaround for https://github.com/buefy/buefy/issues/87 -->
      b-field.small-field
        b-input(
          data-vv-name="player_prediction"
          v-model="player_prediction"
          v-validate="'required|between:1,100'"
          expanded
          placeholder="57"
          )
        p.control
          span.button.is-static %

    .result(v-show="!errors.any() && kelly_percent != null")
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
      player_prediction: 67
    };
  },

  computed: {
    kelly_percent() {
      const percent =
        ((this.player_prediction / 100) * this.bookmaker_coefficent - 1) /
        (this.bookmaker_coefficent - 1);
      if (isFinite(percent)) {
        return percent.toFixed(6);
      } else {
        return null;
      }
    },
    kelly_percent_formatted() {
      return (this.kelly_percent * 100).toFixed(2) + "%";
    },
    kelly_result() {
      const result = this.kelly_percent * this.bank;
      return result.toFixed(2);
    },
    isLoggedIn() {
      return this.$store.getters.isLoggedIn
    }
  }
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
