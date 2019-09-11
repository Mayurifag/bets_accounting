# frozen_string_literal: true

class Generator
  class << self
    def generate_bets(number = 1)
      number = 1 if number < 1 || !number.is_a?(Integer)
      number.times { generate_bet } # TODO: import to prevent N+1
    end

    def generate_bet
      Bet.create!(choice1_id: random_from_class(:participant),
                  choice2_id: random_from_class(:participant),
                  wager: rand(1000..100_000),
                  coefficient: rand(1.2...3.0).ceil(2),
                  outcome: '?' + rand(1..2).to_s,
                  comment: Faker::Lorem.sentence,
                  discipline_id: random_from_class(:discipline),
                  bookmaker_id: random_from_class(:bookmaker),
                  result_variant_id: random_from_class(:result_variant),
                  bet_type_id: random_from_class(:bet_type))
    end

    private

    # TODO: prevent additional reads from database
    def random_from_class(class_name)
      class_name.to_s.classify.constantize.ids.sample
    end
  end
end
