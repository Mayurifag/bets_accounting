# == Schema Information
#
# Table name: participants
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participant < ApplicationRecord
  has_and_belongs_to_many :disciplines

  # has_many :participant_bets
  # has_many :bets, through: :participant_bets

  validates_presence_of :name
end
