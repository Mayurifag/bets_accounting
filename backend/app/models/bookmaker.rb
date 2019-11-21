# frozen_string_literal: true

# Bookmaker with its name: 1huybet or whatever
class Bookmaker < ApplicationRecord
  include Searchable

  validates :name, presence: true
end
