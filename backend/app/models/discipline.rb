# frozen_string_literal: true

# Discipline, game, sport: Dota2/football/whatever. Contains name.
class Discipline < ApplicationRecord
  include Searchable
  # has_and_belongs_to_many :participants
  # belongs_to :bet
  validates :name, presence: true
end
