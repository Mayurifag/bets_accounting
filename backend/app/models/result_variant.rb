# frozen_string_literal: true

# == Schema Information
#
# Table name: result_variants
#
#  id   :bigint(8)        not null, primary key
#  name :string           not null
#

class ResultVariant < ApplicationRecord
  validates_presence_of :name

  def self.win_id
    1
  end

  def self.lost_id
    2
  end
end
