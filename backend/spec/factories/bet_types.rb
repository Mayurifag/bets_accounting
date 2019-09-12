# frozen_string_literal: true

# == Schema Information
#
# Table name: bet_types
#
#  id   :bigint(8)        not null, primary key
#  name :string           not null
#

FactoryBot.define do
  factory :bet_type do
    name { Faker::Lorem.word }
  end
end
