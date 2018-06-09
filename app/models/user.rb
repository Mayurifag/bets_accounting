# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  balance_cents    :integer          default(0), not null
#  balance_currency :string           default("RUB"), not null
#  email            :string           not null
#  name             :string           not null
#  password_digest  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ApplicationRecord
  has_many :balances, class_name: 'BookmakerBalance', dependent: :destroy
end
