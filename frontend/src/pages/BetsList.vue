<template lang="pug">
section.container
  .table-actions
    a.button.m-10.is-primary(@click="newBet") Добавить ставку
    //- TODO: restyling
    .profit.m-10.button(v-if='bets.length') Итого: {{ profit }} ₽
    b-modal(:active.sync="isEditModalActive" has-modal-card)
      bet-edit-modal(:initialBet="initializeNewBet" @submit="saveBet")

  b-table(
    v-show="bets"
    :data='bets'
    paginated
    detailed
    hoverable
    detail-key="id"
    per-page='20'
    :current.sync="current")

    template(slot-scope="props")
      //- TODO: add action on row click
      b-table-column(field="discipline" label="Дисциплина" sortable)
        | {{ props.row.discipline }}
      b-table-column(field="choice1" label="Команда 1" sortable)
        | {{ props.row.choice1 }}
      b-table-column(field="choice2" label="Команда 2" sortable)
        | {{ props.row.choice2 }}
      b-table-column(field="outcome" label="Прогноз" centered)
        | {{ props.row.outcome }}
      b-table-column(field="wager" label="Ставка" numeric sortable)
        | {{ props.row.wager }}
      b-table-column(field="coefficent" label="Коэф-т" numeric sortable)
        | {{ props.row.coefficient }}
      b-table-column(field="result_variant" label="Результат" centered sortable)
        span.tag(:class="resultVariantClass(props.row.result_variant)")
          | {{ props.row.result_variant }}
      b-table-column(field="profit" label="Профит" numeric sortable)
        | {{ props.row.profit }}&nbsp;₽
      b-table-column(field="actions" label="")
        .actions
          a.is-link(@click="editBet(props.row)")
            b-icon(icon='pencil')
          a.is-link(@click="deleteBet(props.row)")
            b-icon(icon='delete' type='is-danger' class='ml-4')

    template(slot="detail" slot-scope="props")
      article.media
        figure.media-left
          p.image.is-64x64
            img(src="../static/placeholder-128x128.png"
                alt="Лого букмекерской конторы (placeholder)")
        .media-content
          .content
            p
              strong {{ props.row.bet_type }}
              small  в БК {{ props.row.bookmaker }} ({{ props.row.created_at }})
              br
              | {{ props.row.comment }}
    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='emoticon-sad' size='is-large')
          p Ставок нет или произошла ошибка.
</template>

<script>
import { mapGetters } from 'vuex';
import api from '../api';
import BetEditModal from '../components/BetEditModal.vue';

export default {
  // props: ['bets'],
  components: { 'bet-edit-modal': BetEditModal },
  computed: {
    ...mapGetters(['bets']),

    profit() {
      return this.bets
        .reduce((prev, cur) => prev + parseFloat(cur.profit), 0)
        .toFixed(2);
    },
  },
  data() {
    return {
      isPaginated: true,
      current: 1,
      isEditModalActive: false,
      initializeNewBet: {
        choice1: '',
        choice2: '',
      },
    };
  },
  methods: {
    showModal(bet = this.initializeNewBet) {
      this.initializeNewBet = bet;
      this.isEditModalActive = true;
    },
    hideModal() {
      this.isEditModalActive = false;
    },
    newBet() {
      this.showModal({});
    },
    editBet(bet) {
      this.showModal(bet);
    },
    saveBet(bet) {
      api.saveBet(bet).then(() => {
        this.$store.dispatch('fetchBets').then(() => {
          this.hideModal();
          this.$toast.open({ message: 'Ставка сохранена', type: 'is-success' });
        });
      });
    },
    deleteBet(bet) {
      // TODO: if user.wantsToConfirm; translation
      this.$dialog.confirm({
        title: 'Удаление ставки',
        message:
          'Вы уверены, что вы хотите <b>удалить</b> эту ставку? Это действие не может быть отменено.',
        confirmText: 'Да',
        cancelText: 'Нет',
        type: 'is-danger',
        hasIcon: true,
        onConfirm: () => {
          api.deleteBet(bet.id).then(() => {
            this.$store.dispatch('fetchBets').then(() => {
              this.$toast.open('Ставка удалена');
            });
          });
        },
      });
    },
    resultVariantClass(resultVariant) {
      if (resultVariant === 'Победа') {
        return 'is-success';
      } if (resultVariant === 'Проигрыш') {
        return 'is-danger';
      }
      return '';
    },
  },
};
</script>

<style scoped lang="scss">
.m-10 {
  margin: 10px;
}
.ml-4 {
  margin-left: 4px;
}
.table-actions {
  justify-content: space-between;
  display: flex;
}
.actions {
  display: inline-flex;
}
</style>
