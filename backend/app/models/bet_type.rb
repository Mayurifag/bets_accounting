# frozen_string_literal: true

# Class of bet: was it live, or pre-match, or whatever
class BetType < ApplicationRecord
  validates :name, presence: true
end
