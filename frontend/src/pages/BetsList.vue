<template lang="pug">
section.container
  .table-actions
    b-button.m-10.is-primary(icon-left='plus' @click="newBet") Добавить ставку
    //- TODO: restyling
    //- TODO: async loading
    .profit.m-10.button(v-if='bets.length') Итого на странице: {{ profit }} ₽
    b-modal(:active.sync="isEditModalActive" has-modal-card)
      betEditModal(:initialBet="initializeNewBet" @submit="saveBet")

  b-table(
    v-show="bets"
    :data='bets'
    paginated
    backend-pagination
    detailed
    hoverable
    detail-key="id"
    :total="total_bets"
    :per-page="bets_perPage"
    @page-change="onPageChange")

    template(slot-scope="props")
      //- TODO: add action on row click
      //- TODO: loading on load bets
      //- TODO: async sorting
      b-table-column(field="discipline" label="Дисциплина")
        | {{ props.row.discipline }}
      b-table-column(field="choice1" label="Команда 1")
        | {{ props.row.choice1 }}
      b-table-column(field="choice2" label="Команда 2")
        | {{ props.row.choice2 }}
      b-table-column(field="outcome" label="Прогноз" centered)
        | {{ props.row.outcome }}
      b-table-column(field="wager" label="Ставка" numeric)
        | {{ props.row.wager }}
      b-table-column(field="coefficent" label="Коэф-т" numeric)
        | {{ props.row.coefficient }}
      b-table-column(field="result_variant" label="Результат" centered)
        span.tag(:class="resultVariantClass(props.row.result_variant)")
          | {{ props.row.result_variant }}
      b-table-column(field="profit" label="Профит" numeric)
        | {{ props.row.profit }}&nbsp;₽
      b-table-column(field="actions" label="")
        .is-inline-flex
          a.is-link(@click="editBet(props.row)")
            b-icon(icon='pencil')
          a.is-link.has-text-danger(@click="deleteBet(props.row)")
            b-icon.ml-4(icon='delete')

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
            b-icon(icon='emoticon-happy' size='is-large')
          p Ставок нет, но, наверное, скоро появятся.
</template>

<script>
import Vue from 'vue';

import Dialog from 'buefy/dist/components/dialog'; // this.$buefy.dialog
import Modal from 'buefy/dist/components/modal'; // b-modal
import Table from 'buefy/dist/components/table'; // b-table
import Toast from 'buefy/dist/components/toast'; // this.$buefy.toast

import { mapGetters } from 'vuex';
import BetEditModal from '../components/BetEditModal.vue';

import api from '../api';

Vue.use(Dialog);
Vue.use(Modal);
Vue.use(Table);
Vue.use(Toast);

export default {
  components: {
    BetEditModal,
  },
  computed: {
    ...mapGetters([
      'bets',
      'total_bets',
      'bets_page',
      'bets_perPage',
    ]),

    profit() {
      return this.bets
        .reduce((prev, cur) => prev + parseFloat(cur.profit), 0)
        .toFixed(2);
    },
  },
  data() {
    return {
      isEditModalActive: false,
      initializeNewBet: {
        choice1: null,
        choice2: null,
      },
    };
  },
  methods: {
    loadBets() {
      this.$store.dispatch('fetchBets');
    },
    onPageChange(page) {
      this.$store.dispatch('setBetsPage', page);
      this.loadBets();
    },
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
      // TODO: if no bet id -> current page reset. vise verca
      api.saveBet(bet).then(() => {
        this.$store.dispatch('fetchBets').then(() => {
          this.hideModal();
          this.$buefy.toast.open({ message: 'Ставка сохранена', type: 'is-success' });
        });
      });
    },
    deleteBet(bet) {
      // TODO: if user.wantsToConfirm; translation
      this.$buefy.dialog.confirm({
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
              this.$buefy.toast.open('Ставка удалена');
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
  mounted() {
    this.loadBets();
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
  display: flex;
  justify-content: space-between;
}
</style>
