# == Schema Information
#
# Table name: bets
#
#  id                :bigint(8)        not null, primary key
#  choice1           :string
#  choice2           :string
#  coefficient       :float            not null
#  comment           :text
#  outcome           :string           not null
#  profit            :decimal(, )
#  wager             :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  bet_type_id       :bigint(8)
#  bookmaker_id      :bigint(8)
#  discipline_id     :bigint(8)
#  event_id          :bigint(8)
#  result_variant_id :bigint(8)
#
# Indexes
#
#  index_bets_on_bet_type_id        (bet_type_id)
#  index_bets_on_bookmaker_id       (bookmaker_id)
#  index_bets_on_discipline_id      (discipline_id)
#  index_bets_on_event_id           (event_id)
#  index_bets_on_result_variant_id  (result_variant_id)
#

FactoryBot.define do
  factory :bet do
    discipline { FactoryBot.create(:discipline) }
    bookmaker { FactoryBot.create(:bookmaker) }
    result_variant { FactoryBot.create(:result_variant) }
    bet_type { FactoryBot.create(:bet_type) }
    event { FactoryBot.create(:event) }

    coefficient { rand(1.2...3.0).ceil(2) }
    comment { Faker::Lorem.sentence }
    wager   { rand(1000..100_000) }
    outcome { 'П' + rand(1..2).to_s }
    choice1 { Faker::Esport.team }
    choice2 { Faker::Esport.team }
  end
end
