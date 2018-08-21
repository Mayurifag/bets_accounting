<template lang="pug">
section.container
	b-table(
		v-show="bets"
		:data='bets'
		paginated
		detailed
		detail-key="id"
		per-page='12'
		:current.sync="current")

		template(slot-scope="props")
			b-table-column(field="discipline" label="Дисциплина" sortable)
				| {{ props.row.discipline }}
			b-table-column(field="choice1" label="Команда 1" sortable)
				| {{ props.row.choice1 }}
			b-table-column(field="choice2" label="Команда 2" sortable)
				| {{ props.row.choice2 }}
			b-table-column(field="outcome" label="Прогноз" sortable)
				| {{ props.row.outcome }}
			b-table-column(field="wager" label="Ставка" numeric sortable)
				| {{ props.row.wager }}
			b-table-column(field="coefficent" label="Коэф-т" numeric sortable)
				| {{ props.row.coefficient }}
			b-table-column(field="result_variant" label="Результат" centered sortable)
				span.tag(:class="{ 'is-success': props.row.result_variant == 'Победа', 'is-danger': props.row.result_variant == 'Проигрыш'}")
					| {{ props.row.result_variant }}
			b-table-column(field="profit" label="Профит" numeric sortable)
				| {{ props.row.profit }}
			b-table-column(field="actions" label="")
				//- b-icon(icon='pencil')
				a.is-link(@click="deleteBet(props.row)")
					b-icon(icon='delete' type='is-danger' class='ml-4')

		template(slot="detail" slot-scope="props")
			article.media
				figure.media-left
					p.image.is-64x64
						img(src="../static/placeholder-128x128.png" alt="Лого букмекерской конторы (placeholder xd)")
				.media-content
					.content
						p
							strong {{ props.row.bet_type }}
							small  в БК {{ props.row.bookmaker }} ({{ new Date(new Date(props.row.created_at).toUTCString()).toLocaleDateString() }})
							br
							| {{ props.row.comment }}
		template(slot='empty')
			section.section
				.content.has-text-grey.has-text-centered
					p
						b-icon(icon='emoticon-sad' size='is-large')
					p Ставок нет.
</template>

<script>
import api from "../api";
import { mapGetters } from "vuex";

export default {
  // props: ['bets'],
  computed: {
    ...mapGetters(["bets"])
  },
  data() {
    return {
      isPaginated: true,
      current: 1
    };
  },
  methods: {
    deleteBet(bet) {
      // TODO: if user.wantsToConfirm; translation
      this.$dialog.confirm({
        title: "Удаление ставки",
        message:
          "Вы уверены, что вы хотите <b>удалить</b> эту ставку? Это действие не может быть отменено.",
        confirmText: "Да",
        cancelText: "Нет",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => {
          api.deleteBet(bet.id).then(() => {
            this.$store.dispatch("fetchBets").then(() => {
              this.$toast.open("Ставка удалена");
            });
          });
        }
      });
    }
  }
};
</script>

<style scoped lang="scss">
.ml-4 {
  margin-left: 4px;
}
</style>
