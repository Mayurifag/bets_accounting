# frozen_string_literal: true

# == Schema Information
#
# Table name: result_variants
#
#  id   :bigint(8)        not null, primary key
#  name :string           not null
#
# Indexes
#
#  index_result_variants_on_name  (name) USING gin
#

class ResultVariant < ApplicationRecord
  validates :name, presence: true

  def self.win_id
    1
  end

  def self.lost_id
    2
  end
end
