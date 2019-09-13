# frozen_string_literal: true

class BetProfitColumnHandler < ApplicationHandler
  PROFIT_RELATED_COLUMNS = %w[wager coefficient result_variant_id].freeze

  def set_profit
    return if profit_related_columns_did_not_changed?

    object.profit = get_new_profit_value
  end

  private

  def profit_related_columns_did_not_changed?
    (PROFIT_RELATED_COLUMNS & saved_changes.keys).present? ||
      wager.blank? ||
      coefficient.blank?
  end

  def get_new_profit_value
    case result_variant_id
    when ResultVariant.win_id
      wager * coefficient - wager
    when ResultVariant.lost_id
      -wager
    else
      0
    end
  end
end
