# frozen_string_literal: true

# == Schema Information
#
# Table name: participants
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_participants_on_name  (name) USING gin
#

class Participant < ApplicationRecord
  include Searchable
  # has_and_belongs_to_many :disciplines

  # TODO: field full_name

  # has_many :participant_bets
  # has_many :bets, through: :participant_bets

  validates :name, presence: true
end
