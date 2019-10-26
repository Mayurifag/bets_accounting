# frozen_string_literal: true

class Bookmaker < ApplicationRecord
  include Searchable

  validates :name, presence: true
end
