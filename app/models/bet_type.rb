# == Schema Information
#
# Table name: bet_types
#
#  id   :bigint(8)        not null, primary key
#  name :string
#

class BetType < ApplicationRecord
  validates_presence_of :name
end
