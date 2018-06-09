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
  has_one :discipline
  has_one :bookmaker
  has_one :event
  has_one :result_variant
  has_one :bet_type

  after_save :check_for_profit

  # has_many :participants, through: :participant_bets
  # has_many :participant_bets

  # belongs_to :user

  # validates_presence_of :bookmaker, :sides, :discipline

  # accepts_nested_attributes_for :participants

  def as_json(options={})
    # TODO: refactor
    h = super(except: [:updated_at, :bookmaker_id, :discipline_id, :event_id, :result_variant_id, :bet_type_id])
    h[:bookmaker]      = Bookmaker.find(bookmaker_id).name
    h[:discipline]     = Discipline.find(discipline_id).name
    h[:result_variant] = ResultVariant.find(result_variant_id).name
    h[:bet_type]       = BetType.find(bet_type_id).name
    # h[:formatted_profit] = number_with_precision(profit.to_f, precision: 2, separator: ',', delimiter: '.')
    if event_id.present?
      h[:event]        = Event.find(self.event_id).name
    end
    h
  end

  def result
    ResultVariant.find(result_variant_id).name
  end

  def check_for_profit
    # TODO: only if changed
    if result_variant_id.present? || wager.present? || coefficient.present?
      if result == 'Победа'
        self.update_column(:profit, (wager * coefficient).round(2))
      elsif result == 'Возврат'
        self.update_column(:profit, 0)
      else
        self.update_column(:profit, 0 - wager)
      end
    end
  end
end
