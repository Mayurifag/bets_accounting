# frozen_string_literal: true

class BetType < ApplicationRecord
  validates :name, presence: true
end
