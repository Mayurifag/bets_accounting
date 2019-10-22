# frozen_string_literal: true

FactoryBot.define do
  factory :bet do
    discipline
    bookmaker
    result_variant_id { ResultVariant.win_id }
    bet_type
    event
    choice1 { FactoryBot.build(:participant) }
    choice2 { FactoryBot.build(:participant) }

    coefficient { 1.4 }
    comment { 'test' }
    wager { 111 }
    outcome { 'П1' }
  end
end
