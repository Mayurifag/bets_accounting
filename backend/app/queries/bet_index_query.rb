# frozen_string_literal: true

class BetIndexQuery < BaseQuery
  def call
    set_klass
    set_order
    avoid_n_plus_one
    set_pagination
    return_result_with_pagy_meta
  end

  private

  def klass
    Bet
  end

  def set_klass
    @scope = klass
  end

  def set_order
    @scope = @scope.newest_first
  end

  def avoid_n_plus_one
    @scope = @scope.eager_load(
      :discipline, :result_variant, :bet_type, :bookmaker, :choice1, :choice2,
      :event
    )
  end
end
