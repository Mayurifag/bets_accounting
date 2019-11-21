# frozen_string_literal: true

# Participant with its name. May be the team or single person or whatever.
# I wish to add the full name and short names here (jsonb) and make autocomplete
# handle the short name.
class Participant < ApplicationRecord
  include Searchable
  # has_and_belongs_to_many :disciplines

  # TODO: field full_name

  # has_many :participant_bets
  # has_many :bets, through: :participant_bets

  validates :name, presence: true
end
