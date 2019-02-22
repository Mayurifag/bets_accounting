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
  include PgSearch

  FIELDS_TO_SHOW = %w[choice1 choice2 discipline result_variant
                      event bet_type bookmaker]

  scope :newest_first, -> { order(created_at: :desc) }

  belongs_to :discipline,     optional: true
  belongs_to :result_variant, optional: true
  belongs_to :bet_type,       optional: true
  belongs_to :bookmaker,      optional: true
  belongs_to :event,          optional: true
  belongs_to :choice1, class_name: 'Participant', foreign_key: :choice1_id
  belongs_to :choice2, class_name: 'Participant', foreign_key: :choice2_id


  validates :coefficient, allow_blank: true,
                          numericality: { greater_than_or_equal_to: 1.0 }

  validates :wager, numericality: { greater_than: 0 }, allow_blank: true

  after_save :update_profit_column

  def as_json(_options = {})
    h = super(except: %i[choice1_id choice2_id profit updated_at bookmaker_id
                         discipline_id event_id result_variant_id bet_type_id])
    FIELDS_TO_SHOW.each { |field| h[field.to_sym] = self.send(field)&.name }
    h[:profit] = formatted_profit
    h
  end

  def formatted_profit
    number_with_precision(profit.to_f, precision: 2)
  end

  def update_profit_column
    return if wager.blank? || coefficient.blank?
    case result_variant&.id
    when 1
      set_profit_as_win
    when 2
      set_profit_as_lost
    else
      set_profit_as_zero
    end
  end

  private

  def set_profit_as_win
    update_column(:profit, (wager * coefficient) - wager)
  end

  def set_profit_as_lost
    update_column(:profit, 0 - wager)
  end

  def set_profit_as_zero
    update_column(:profit, 0)
  end
end

# TODO List:
# 1. Optional choices (has to be one or two or three or more)
# 2. Refactor 'as_json' to be in views or builder or elsewhere
# 3. Move formatted_profit to the presenters
# 4. Move callback to service

# Additional things:
# has_many :participants, through: :participant_bets
# has_many :participant_bets
# accepts_nested_attributes_for :participants
# belongs_to :user
# TODO: enum on result_variants // bet_types??
# TODO: default profit 0?

# validates_presence_of :coefficient, :wager, :outcome
