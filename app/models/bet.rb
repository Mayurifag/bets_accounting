# == Schema Information
#
# Table name: bets
#
#  id                :bigint(8)        not null, primary key
#  choice1           :string
#  choice2           :string
#  coefficient       :float            not null
#  comment           :text
#  outcome           :string           not null
#  profit            :decimal(, )
#  wager             :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  bet_type_id       :bigint(8)
#  bookmaker_id      :bigint(8)
#  discipline_id     :bigint(8)
#  event_id          :bigint(8)
#  result_variant_id :bigint(8)
#
# Indexes
#
#  index_bets_on_bet_type_id        (bet_type_id)
#  index_bets_on_bookmaker_id       (bookmaker_id)
#  index_bets_on_discipline_id      (discipline_id)
#  index_bets_on_event_id           (event_id)
#  index_bets_on_result_variant_id  (result_variant_id)
#

class Bet < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :discipline
  belongs_to :result_variant
  belongs_to :bet_type, optional: true
  belongs_to :bookmaker, optional: true
  belongs_to :event, optional: true

  after_save :update_profit_column

  # has_many :participants, through: :participant_bets
  # has_many :participant_bets

  # belongs_to :user

  validates_presence_of :coefficient, :wager, :outcome

  # accepts_nested_attributes_for :participants

  def as_json(_options = {})
    h = super(except: %i[profit updated_at bookmaker_id discipline_id event_id result_variant_id bet_type_id])
    h[:discipline]     = discipline.name
    h[:result_variant] = result_variant.name
    h[:profit]         = formatted_profit

    h[:event]        = Event.find(event_id).name if event_id.present?

    h[:bet_type]     = BetType.find(bet_type_id).name if bet_type

    h[:bookmaker] = bookmaker.name if bookmaker
    h
  end

  def result
    ResultVariant.find(result_variant_id).name
  end

  def formatted_profit
    number_with_precision(profit.to_f, precision: 2)
  end

  def update_profit_column
    # TODO: only if changed
    if result_variant_id.present? || wager.present? || coefficient.present?
      if result == 'Победа'
        update_column(:profit, wager * coefficient)
      elsif result == 'Возврат'
        update_column(:profit, 0)
      else
        update_column(:profit, 0 - wager)
      end
    end
  end
end
