# frozen_string_literal: true

class BetsController < ApplicationController
  before_action :set_bet, only: %i[show update destroy]
  before_action :transform_bet_params, only: %i[create update]

  # GET /bets
  def index
    # TODO: pseudo-pagination
    @bets = avoid_n_plus_one_query(Bet.newest_first)
    json_response(BetBlueprint.render(@bets))
  end

  # POST /bets
  def create
    @bet = Bet.new(bet_params)

    if @bet.save
      json_response(BetBlueprint.render(@bet), :created)
    else
      json_response(@bet.errors, :unprocessable_entity)
    end
  end

  # GET /bets/:id
  def show
    json_response(BetBlueprint.render(@bet))
  end

  # PUT /bets/:id
  def update
    if @bet.update(bet_params)
      json_response(BetBlueprint.render(@bet))
    else
      json_response(@bet.errors, :unprocessable_entity)
    end
  end

  # DELETE /bets/:id
  def destroy
    @bet.destroy
    head :no_content
  end

  private

  def avoid_n_plus_one_query(bets)
    bets.eager_load(:discipline, :result_variant, :bet_type, :bookmaker,
                    :choice1, :choice2)
  end

  # TODO: something wrong with created_at here, need a new column ['betted_at'?]
  # TODO: autocomplete etc. for event

  ATTRS = %i[coefficient comment wager profit event_id event outcome
             choice1_id choice2_id discipline_id result_variant_id
             bet_type_id bookmaker_id].freeze

  def bet_params
    params.require(:bet).permit(*ATTRS)
  end

  def set_bet
    @bet = Bet.find(params[:id])
  end

  def transform_bet_params
    return if params[:bet].blank?

    params[:bet] = BetParamsTransformationHandler.new(params[:bet]).call
  end
end