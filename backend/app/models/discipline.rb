# frozen_string_literal: true

class Discipline < ApplicationRecord
  include Searchable
  # has_and_belongs_to_many :participants
  # belongs_to :bet
  validates :name, presence: true
end
