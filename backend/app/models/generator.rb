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
      return Bet.create!(random_bet_params) unless build

      bet = Bet.new(random_bet_params)
      bet.update_profit_column
      bet
    end

    private

    # Switch on the cache if you want to import thousands of bets in development environment.
    # Don't forget to switch it off!
    #
    # 1) dip rails dev:cache
    # 2) dip rails c
    # 3) Generator.generate_bets(15000)
    # 4) exit
    # 5) dip rails dev:cache
    #
    def random_from_class(class_name)
      klass_string = class_name.to_s.classify
      ids = Rails.cache.fetch(klass_string, expires_in: 1.minutes) do
        klass_string.constantize.ids
      end

      ids.sample
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
