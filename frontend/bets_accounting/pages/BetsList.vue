<template lang="pug">
.bets
  b-table(v-show="bets && bets.length" :data='bets' :striped="isStriped" :hoverable="isHoverable")
    template(slot-scope="props")
      b-table-column(field="discipline" label="Игра")
        | {{ props.row.discipline }}
      b-table-column(field="discipline" label="Тип ставки")
        | {{ props.row.bet_type }}
      b-table-column(field="choice1" label="Команда 1")
        | {{ props.row.choice1 }}
      b-table-column(field="choice2" label="Команда 2")
        | {{ props.row.choice2 }}
      b-table-column(field="outcome" label="Прогноз")
        | {{ props.row.outcome }}
      b-table-column(field="wager" label="Ставка" numeric)
        | {{ props.row.wager }}
      b-table-column(field="coefficent" label="Коэффициент" numeric)
        | {{ props.row.coefficient }}
      b-table-column(field="result_variant" label="Результат" numeric)
        | {{ props.row.result_variant }}
      b-table-column(field="result_variant" label="Профит" numeric)
        | {{ props.row.profit }}
      b-table-column(field="comment" label="Комментарий")
        | {{ props.row.comment }}
      b-table-column(field="bookmaker" label="БК")
        | {{ props.row.bookmaker }}
      <!-- TODO: refactor this date -->
      b-table-column(field="created_at" label="Дата" centered="")
        span.tag.is-success
          | {{ new Date(new Date(props.row.created_at).toUTCString()).toLocaleDateString() }}
    template(slot="empty")
      section.section
        .content.has-text-grey.has-text-centered
          p Не загрузилось.
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    // props: ['bets'],
    computed: {
      ...mapGetters(['bets'])
    },
    data () {
      return {
        isHoverable: true,
        isStriped: true
      }
    },
  }
</script>
