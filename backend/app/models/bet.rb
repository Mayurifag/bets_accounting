# frozen_string_literal: true

class Bet < ApplicationRecord
  scope :newest_first, -> { order(created_at: :desc) }

  belongs_to :discipline, optional: true
  belongs_to :result_variant, optional: true
  belongs_to :bet_type, optional: true
  belongs_to :bookmaker, optional: true
  belongs_to :event, optional: true
  belongs_to :choice1, class_name: 'Participant', foreign_key: :choice1_id
  belongs_to :choice2, class_name: 'Participant', foreign_key: :choice2_id

  validates :wager, numericality: { greater_than: 0 }, allow_blank: true
  validates :coefficient, allow_blank: true,
                          numericality: { greater_than_or_equal_to: 1.0 }

  before_save :update_profit_column

  def update_profit_column
    BetProfitColumnHandler.new(self).set_profit
  end
end

# TODO: List:
# - Optional choices (has to be one or two or three or more)

# Additional things:
# has_many :participants, through: :participant_bets
# has_many :participant_bets
# accepts_nested_attributes_for :participants
# belongs_to :user
# TODO: enum on result_variants // bet_types??

# validates_presence_of :coefficient, :wager, :outcome
