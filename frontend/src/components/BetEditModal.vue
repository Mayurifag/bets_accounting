<template lang="pug">
  form(@submit.prevent="submitForm")
    .modal-card
      section.modal-card-body
        //- TODO: flex wraping?
        .inline-flex

          //- TODO: warning if choice1 == choice2
          b-field(label="Команда 1" class="mr-8")
            b-autocomplete(v-model='bet.choice1', :data='participants',
                           field='name', @input='getParticipants(bet.choice1)',
                           @select='option => selected = option', autofocus)
              template(slot-scope='props')
                .media
                  .media-content
                    | {{ props.option.name }}
          b-field(label="Команда 2" class="mr-8")
            b-autocomplete(v-model='bet.choice2', :data='participants',
                           field='name', @input='getParticipants(bet.choice2)',
                           @select='option => selected = option')
              template(slot-scope='props')
                .media
                  .media-content
                    | {{ props.option.name }}
          b-field(label="Прогноз")
            b-input(type="text" v-model="bet.outcome")


        .inline-flex
          b-field(label="Дисциплина" class="mr-8")
            b-autocomplete(v-model='bet.discipline', :data='disciplines',
                           field='name', @input='getDisciplines',
                           @select='option => selected = option')
              template(slot-scope='props')
                .media
                  .media-content
                    | {{ props.option.name }}

          b-field(label="Ставка" class="mr-8")
            b-field(:type="errors.has('bet.wager') ? 'is-danger' : ''")
              p.control
                span.button.is-static ₽
              b-input(type="text" data-vv-name="bet.wager"
                      v-validate="'numeric|required|between:0,2147483647'"
                      v-model="bet.wager" class='small-input')

          b-field(label="Коэффициент" class="mr-8"
                  :type="errors.has('bet.coefficient') ? 'is-danger' : ''")
            b-input(type="text" v-model="bet.coefficient"
                    data-vv-name="bet.coefficient" class='medium-input'
                    v-validate="'required|between:1,2147483647'")


        b-field
          b-radio-button(v-model='bet.result_variant' native-value='Победа' type='is-success')
            b-icon(icon='check')
            span Победа
          b-radio-button(v-model='bet.result_variant' native-value='Проигрыш' type='is-danger')
            b-icon(icon='close')
            span Проигрыш
          b-radio-button(v-model='bet.result_variant' native-value='Возврат')
            | Возврат


        b-collapse(:open="false").card
          .card-header(slot='trigger' slot-scope='props')
            p.card-header-title
              | Дополнительно
            a.card-header-icon
              b-icon(:icon="props.open ? 'menu-down' : 'menu-up'")
          .card-content
            .content
              .inline-flex
                b-field(label="Букмекерская контора" class="mr-8")
                  //- TODO: refactor this
                  b-select(v-model='bet.bookmaker')
                    option(value='Другая') Другая
                    option(value='GG.Bet') GG.Bet
                    option(value='Париматч') Париматч
                    option(value='EGB') EGB
                    option(value='Loot.Bet') Loot.Bet
                    option(value='Leon') Leon


                b-radio(v-model='bet.bet_type' native-value='Прематч')
                  | Прематч
                b-radio(v-model='bet.bet_type' native-value='Лайв')
                  | Лайв
              b-field(label="Комментарий")
                b-input(type="text" v-model="bet.comment")


      footer.modal-card-foot
        button.button(type="button" @click="$parent.close()") Закрыть
        button.button.is-primary(:disabled="errors.any()") {{ bet.id ? 'Сохранить' : 'Создать' }}
</template>

<script>
import Vue from 'vue';
import api from '../api';

export default {
  props: ['initialBet'],
  data() {
    return {
      bet: Vue.util.extend({}, this.initialBet),
      participants: [],
      disciplines: [],
      selected: null,
    };
  },
  methods: {
    submitForm() {
      this.$validator.validateAll().then((isValid) => {
        if (isValid) {
          this.saveBet();
        }
      });
    },
    saveBet() {
      this.$emit('submit', this.bet);
    },
    getParticipants(model) {
      this.participants = [];
      api
        .autocomplete('Participant', model)
        .then(({ data }) => {
          data.forEach(item => this.participants.push(item));
        })
        .catch((error) => {
          throw error;
        });
    },
    getDisciplines() {
      this.disciplines = [];
      api
        .autocomplete('Discipline', this.bet.discipline)
        .then(({ data }) => {
          data.forEach(item => this.disciplines.push(item));
        })
        .catch((error) => {
          throw error;
        });
    },
  },
};
</script>

<style scoped lang="scss">
.small-input {
  width: 80px;
}
.medium-input {
  width: 100px;
}
// TODO: move to have everythere
.inline-flex {
  display: inline-flex;
}
.mr-8 {
  margin-right: 8px;
}
.flex {
  display: flex;
}
</style>
