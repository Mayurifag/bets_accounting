# == Schema Information
#
# Table name: result_variants
#
#  id   :bigint(8)        not null, primary key
#  name :string
#

FactoryBot.define do
  factory :result_variant do
    name { Faker::Lorem.word }
  end
end
