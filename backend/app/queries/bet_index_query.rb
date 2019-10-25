# frozen_string_literal: true

class BetIndexQuery < BaseQuery
  class << self
    # TODO: test the sequel here :)
    def call
      set_class
      set_order
      avoid_n_plus_one
      # TODO: pagination
      return_result
    end

    private

    def return_result
      @scope
    end

    def set_class
      @scope = Bet
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
end
