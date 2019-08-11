# == Schema Information
#
# Table name: bookmaker_balances
#
#  id               :bigint(8)        not null, primary key
#  balance_cents    :integer          default(0), not null
#  balance_currency :string           default("RUB"), not null
#  bookmaker_id     :bigint(8)
#  user_id          :bigint(8)
#
# Indexes
#
#  index_bookmaker_balances_on_bookmaker_id  (bookmaker_id)
#  index_bookmaker_balances_on_user_id       (user_id)
#

class BookmakerBalance < ApplicationRecord
  belongs_to :user
  has_one :bookmaker
end
