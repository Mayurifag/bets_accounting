# frozen_string_literal: true

# == Schema Information
#
# Table name: bet_types
#
#  id   :bigint(8)        not null, primary key
#  name :string           not null
#
# Indexes
#
#  index_bet_types_on_name  (name) USING gin
#

class BetType < ApplicationRecord
  # TODO: set bet type in specs, delete factory, etc etc
  validates :name, presence: true
end
