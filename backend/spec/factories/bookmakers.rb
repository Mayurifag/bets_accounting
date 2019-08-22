# == Schema Information
#
# Table name: bookmakers
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :bookmaker do
    name { Faker::Company.name }
  end
end
