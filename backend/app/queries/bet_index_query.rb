# frozen_string_literal: true

class BetIndexQuery < BaseQuery
  class << self
    # TODO: test the sequel here :)
    def call
      set_order
      avoid_n_plus_one
      @scope
    end

    private

    def set_order
      @scope = Bet.newest_first
    end

    def avoid_n_plus_one
      @scope = @scope.eager_load(
        :discipline, :result_variant, :bet_type, :bookmaker, :choice1, :choice2,
        :event
      )
    end
  end
end
