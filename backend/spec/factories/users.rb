# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:email) { |n| "user#{n}@test.test" }
    password { 'password1' }
    password_confirmation { 'password1' }
  end
end
