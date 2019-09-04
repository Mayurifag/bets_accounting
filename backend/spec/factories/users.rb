# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           default(""), not null
#  name            :string
#  password_digest :string
#  username        :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#


FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:username) { |n| "login#{n}" }
    sequence(:email) { |n| "user.#{n}@mail.ru" }
    password { 'password1' }
    password_confirmation { 'password1' }
  end
end
