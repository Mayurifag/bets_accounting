# frozen_string_literal: true

class Generator
  class << self
    def generate_bets(number = 1)
      return generate_bet if this_is_not_a_positive_integer?(number)

      bets = []
      number.times { bets << generate_bet(build: true) }
      Bet.import! bets, batch_size: 1000
    end

    def generate_bet(build: false)
      bet = Bet.new(random_bet_params)

      return bet.save! unless build

      bet.update_profit_column
      bet
    end

    private

    def random_bet_params
      { choice1_id: Participant.memoized_sample_id,
        choice2_id: Participant.memoized_sample_id,
        wager: rand(1000..100_000),
        coefficient: rand(1.1...3.0).ceil(2),
        outcome: 'П' + %w[1 2].sample,
        comment: Faker::Lorem.sentence,
        discipline_id: Discipline.memoized_sample_id,
        bookmaker_id: Bookmaker.memoized_sample_id,
        result_variant_id: ResultVariant.memoized_sample_id,
        bet_type_id: BetType.memoized_sample_id }
    end

    def this_is_not_a_positive_integer?(number)
      number < 1 || !number.is_a?(Integer)
    end
  end
end
