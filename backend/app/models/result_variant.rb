# frozen_string_literal: true

class ResultVariant < ApplicationRecord
  validates :name, presence: true

  def self.win_id
    1
  end

  def self.lost_id
    2
  end
end
