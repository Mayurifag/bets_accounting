# frozen_string_literal: true

class Participant < ApplicationRecord
  include Searchable
  # has_and_belongs_to_many :disciplines

  # TODO: field full_name

  # has_many :participant_bets
  # has_many :bets, through: :participant_bets

  validates :name, presence: true
end
