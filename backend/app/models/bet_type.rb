# frozen_string_literal: true

# == Schema Information
#
# Table name: bet_types
#
#  id   :bigint(8)        not null, primary key
#  name :string           not null
#

class BetType < ApplicationRecord
  # TODO: set bet type in specs, delete factory, etc etc
  validates_presence_of :name
end
