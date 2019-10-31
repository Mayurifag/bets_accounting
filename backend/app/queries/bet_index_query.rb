# frozen_string_literal: true

class BetIndexQuery < BaseQuery
  # TODO: test the sequel here :)
  def call
    set_order
    avoid_n_plus_one
    # maybe denormalization: https://stackoverflow.com/questions/6618366/improving-offset-performance-in-postgresql
    set_pagination
    return_result_with_pagy_meta
  end

  private

  def klass
    Bet
  end

  def set_order
    @scope = klass.newest_first
  end

  def avoid_n_plus_one
    @scope = @scope.eager_load(
      :discipline, :result_variant, :bet_type, :bookmaker, :choice1, :choice2,
      :event
    )
  end
end
