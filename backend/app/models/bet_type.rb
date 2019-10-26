# frozen_string_literal: true

class BetType < ApplicationRecord
  # TODO: set bet type in specs, delete factory, etc etc
  validates :name, presence: true
end
