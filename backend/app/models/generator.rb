# frozen_string_literal: true

# Custom class used in tests or for development purposes to simply generate many
# bets with random valid params.
class Generator
  class << self
    def generate_bets(total = 1)
      return generate_random_bet if this_is_not_a_positive_integer?(total)

      bets = []
      total.times { bets << build_random_bet }
      Bet.import! bets, batch_size: 1000
    end

    private

    def build_random_bet
      bet = Bet.new(random_bet_params)
      bet.assign_new_profit_value!
      bet
    end

    def generate_random_bet
      bet = build_random_bet
      bet.save!
    end

    def random_bet_params
      {choice1_id: Participant.memoized_sample_id,
       choice2_id: Participant.memoized_sample_id,
       wager: rand(1000..100_000),
       coefficient: rand(1.1...3.0).ceil(2),
       outcome: "П" + %w[1 2].sample,
       comment: Faker::Lorem.sentence,
       discipline_id: Discipline.memoized_sample_id,
       bookmaker_id: Bookmaker.memoized_sample_id,
       result_variant_id: ResultVariant.memoized_sample_id,
       bet_type_id: BetType.memoized_sample_id,}
    end

    def this_is_not_a_positive_integer?(number)
      number < 1 || !number.is_a?(Integer)
    end
  end
end
