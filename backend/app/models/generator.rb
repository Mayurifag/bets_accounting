# frozen_string_literal: true

class Generator
  class << self
    def generate_bets(number = 1)
      number = 1 if this_is_not_a_positive_integer?(number)

      bets = []
      number.times { bets << generate_bet(build: true) }
      Bet.import! bets
    end

    def generate_bet(build: false)
      build ? Bet.new(random_bet_params) : Bet.create!(random_bet_params)
    end

    private

    # TODO: prevent additional selects from database via metaprogramming / caching
    # there is also https://github.com/haopingfan/quick_random_records
    def random_from_class(class_name)
      class_name.to_s.classify.constantize.ids.sample
    end

    def random_bet_params
      { choice1_id: random_from_class(:participant),
        choice2_id: random_from_class(:participant),
        wager: rand(1000..100_000),
        coefficient: rand(1.2...3.0).ceil(2),
        outcome: 'П' + rand(1..2).to_s,
        comment: Faker::Lorem.sentence,
        discipline_id: random_from_class(:discipline),
        bookmaker_id: random_from_class(:bookmaker),
        result_variant_id: random_from_class(:result_variant),
        bet_type_id: random_from_class(:bet_type) }
    end

    def this_is_not_a_positive_integer?(number)
      number < 1 || !number.is_a?(Integer)
    end
  end
end
