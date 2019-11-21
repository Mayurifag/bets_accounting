# frozen_string_literal: true

# Event with name: The International of dota 2, etc.
# TODO: belongs_to discipline
class Event < ApplicationRecord
  include Searchable

  validates :name, presence: true
end
