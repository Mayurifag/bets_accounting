# frozen_string_literal: true

class Generator
  # TODO: move to lib ; rename to fake generator?

  def self.generate_bets(number = 1)
    # throw an error // rewrite to give back only a bet if number = 1, not number of created bets
    number = 1 if number < 1 || !number.is_a?(Integer)
    number.times { generate_bet }
  end

  def self.generate_bet
    Bet.create!(choice1_id: Participant.ids.sample,
                choice2_id: Participant.ids.sample,
                wager: rand(1000..100_000),
                coefficient: rand(1.2...3.0).ceil(2),
                outcome: 'П' + rand(1..2).to_s,
                comment: 'random comment ' + rand(1000..9999).to_s,
                discipline_id: Discipline.ids.sample,
                bookmaker_id: Bookmaker.ids.sample,
                result_variant_id: ResultVariant.ids.sample,
                bet_type_id: BetType.ids.sample)
  end
end
