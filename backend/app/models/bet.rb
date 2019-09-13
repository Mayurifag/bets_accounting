# frozen_string_literal: true

# == Schema Information
#
# Table name: bets
#
#  id                :bigint(8)        not null, primary key
#  coefficient       :float            not null
#  comment           :text
#  outcome           :string           not null
#  profit            :decimal(, )
#  wager             :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  bet_type_id       :bigint(8)
#  bookmaker_id      :bigint(8)
#  choice1_id        :bigint(8)
#  choice2_id        :bigint(8)
#  discipline_id     :bigint(8)
#  event_id          :bigint(8)
#  result_variant_id :bigint(8)
#
# Indexes
#
#  index_bets_on_bet_type_id        (bet_type_id)
#  index_bets_on_bookmaker_id       (bookmaker_id)
#  index_bets_on_choice1_id         (choice1_id)
#  index_bets_on_choice2_id         (choice2_id)
#  index_bets_on_discipline_id      (discipline_id)
#  index_bets_on_event_id           (event_id)
#  index_bets_on_result_variant_id  (result_variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (choice1_id => participants.id)
#  fk_rails_...  (choice2_id => participants.id)
#

class Bet < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include PgSearch::Model

  scope :newest_first, -> { order(created_at: :desc) }

  belongs_to :discipline,     optional: true
  belongs_to :result_variant, optional: true
  belongs_to :bet_type,       optional: true
  belongs_to :bookmaker,      optional: true
  belongs_to :event,          optional: true
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
