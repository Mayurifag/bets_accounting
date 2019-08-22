# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:username) { |n| "login#{n}" }
    sequence(:email) { |n| "user.#{n}@mail.ru" }
    password { 'password1' }
    password_confirmation { 'password1' }
  end
end
