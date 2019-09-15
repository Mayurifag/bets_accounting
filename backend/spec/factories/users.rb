# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:email) { |n| "user#{n}@test.test" }
    password { 'password1' }
    password_confirmation { 'password1' }
  end
end
