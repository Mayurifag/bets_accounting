# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Esport.event }
  end
end
