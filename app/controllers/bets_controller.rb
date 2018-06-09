class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :update, :destroy]

  # GET /bets
  def index
    # TODO: N+1
    @bets = Bet.all
    json_response(@bets)
  end

  # POST /bets
  def create
    @bet = Bet.create!(bet_params)
    json_response(@bet, :created)
  end

  # GET /bets/:id
  def show
    json_response(@bet)
  end

  # PUT /bets/:id
  def update
    @bet.update(bet_params)
    head :no_content
  end

  # DELETE /bets/:id
  def destroy
    @bet.destroy
    head :no_content
  end

  private

  def bet_params
    params.permit(:result, :coefficient, :comment)
  end

  def set_bet
    @bet = Bet.find(params[:id])
  end
end
