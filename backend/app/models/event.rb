# frozen_string_literal: true

class Event < ApplicationRecord
  include Searchable

  validates :name, presence: true
end
