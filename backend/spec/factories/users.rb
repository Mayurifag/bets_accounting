# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.test" }
    password { "password1" }
    password_confirmation { "password1" }
  end
end
