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

  scope :newest_first, -> { order(created_at: :desc) }

  belongs_to :discipline, optional: true
  belongs_to :result_variant, optional: true
  belongs_to :bet_type, optional: true
  belongs_to :bookmaker, optional: true
  belongs_to :event, optional: true
  # TODO: optional
  belongs_to :choice1, class_name: 'Participant', foreign_key: :choice1_id
  belongs_to :choice2, class_name: 'Participant', foreign_key: :choice2_id

  # has_many :participants, through: :participant_bets
  # has_many :participant_bets
  # accepts_nested_attributes_for :participants
  # belongs_to :user
  # TODO: enum on result_variants // bet_types??
  # TODO: default profit 0?

  # validates_presence_of :coefficient, :wager, :outcome
  validates :coefficient, numericality: { greater_than_or_equal_to: 1.0 }, allow_blank: true
  validates :wager, numericality: { greater_than: 0 }, allow_blank: true

  after_save :update_profit_column
  # TODO: after_save :delete_bet_if_all_fields_blank

  # have to do this in views but as_json is much faster
  def as_json(_options = {})
    h = super(except: %i[choice1_id choice2_id profit updated_at bookmaker_id
                         discipline_id event_id result_variant_id bet_type_id])
    h[:profit]         = formatted_profit
    # FIXME: safe navigator??
    h[:choice1]        = choice1.name if choice1
    h[:choice2]        = choice2.name if choice2
    h[:discipline]     = discipline.name if discipline
    h[:result_variant] = result_variant.name if result_variant
    h[:event]          = event.name if event
    h[:bet_type]       = bet_type.name if bet_type
    h[:bookmaker]      = bookmaker.name if bookmaker
    h
  end

  def formatted_profit
    number_with_precision(profit.to_f, precision: 2)
  end

  def result
    result_variant&.name
  end

  def update_profit_column
    return if wager.blank? || coefficient.blank?
    case result
    when 'Победа'
      update_column(:profit, (wager * coefficient) - wager)
    when 'Проигрыш'
      update_column(:profit, 0 - wager)
    else
      update_column(:profit, 0)
    end
  end

end
