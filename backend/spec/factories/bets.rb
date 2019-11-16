# frozen_string_literal: true

FactoryBot.define do
  factory :bet do
    choice1 { FactoryBot.build(:participant) }
    choice2 { FactoryBot.build(:participant) }

    coefficient { 1.4 }
    wager { 111 }
    outcome { "П1" }
    profit { 0 }
  end
end
