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

class Participant < ApplicationRecord
  # has_and_belongs_to_many :disciplines

  # TODO: field full_name

  # has_many :participant_bets
  # has_many :bets, through: :participant_bets

  include PgSearch::Model
  pg_search_scope :autocomplete_name, against: :name,
                                      using: {
                                        tsearch: { prefix: true }
                                      },
                                      order_within_rank: 'created_at ASC'

  validates_presence_of :name
end
