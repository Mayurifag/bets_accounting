class BetsController < ApplicationController
  before_action :set_bet, only: %i[show update destroy]
  before_action :transform_bet_params, only: %i[create update]

  # GET /bets
  def index
    # TODO: pseudo-pagination
    @bets = Bet.includes(:discipline, :result_variant, :bet_type, :bookmaker, :choice1, :choice2).newest_first
    json_response(@bets)
  end

  # POST /bets
  def create
    @bet = Bet.new(bet_params)

    if @bet.save
      json_response(@bet, :created)
    else
      json_response(@bet.errors, :unprocessable_entity)
    end
  end

  # TODO: not used
  # GET /bets/:id
  def show
    json_response(@bet)
  end

  # PUT /bets/:id
  def update
    if @bet.update(bet_params)
      json_response(@bet)
    else
      json_response(@bet.errors, :unprocessable_entity)
    end
  end

  # DELETE /bets/:id
  def destroy
    if @bet.destroy
      head :no_content
    else
      json_response(@bet.errors, :unprocessable_entity)
    end
  end

  private

  def bet_params
    # TODO: something wrong with created_at here, need a new column ['betted_at'?]
    params.require(:bet).permit(:id, :coefficient, :comment, :wager, :profit,
                                :discipline, :event_id, :outcome, :bet_type,
                                :choice1_id, :choice2_id, :created_at,
                                :result_variant, :bookmaker, :discipline_id,
                                :result_variant_id, :bet_type_id, :bookmaker_id)
  end

  def set_bet
    @bet = Bet.find(params[:id])
  end

  # TODO: move this shit to service
  def transform_bet_params
    if params[:bet].has_key?('choice1')
      if params[:bet][:choice1].blank?
        params[:bet][:choice1_id] = nil
      else
        choice1 = Participant.find_or_create_by(name: params[:bet][:choice1])
        params[:bet][:choice1_id] = choice1.id
      end
      params[:bet].delete('choice1')
    end

    if params[:bet].has_key?('choice2')
      if params[:bet][:choice2].blank?
        params[:bet][:choice2_id] = nil
      else
        choice2 = Participant.find_or_create_by(name: params[:bet][:choice2])
        params[:bet][:choice2_id] = choice2.id
      end
      params[:bet].delete('choice2')
    end

    if params[:bet].has_key?('discipline')
      if params[:bet][:discipline].blank?
        params[:bet][:discipline_id] = nil
      else
        discipline = Discipline.find_or_create_by(name: params[:bet][:discipline])
        params[:bet][:discipline_id] = discipline.id
      end
      params[:bet].delete('discipline')
    end

    if params[:bet].has_key?('result_variant')
      if params[:bet][:result_variant].blank?
        params[:bet][:result_variant_id] = nil
      else
        result_variant = ResultVariant.find_by(name: params[:bet][:result_variant])
        params[:bet][:result_variant_id] = result_variant.id
      end
      params[:bet].delete('result_variant')
    end

    if params[:bet].has_key?('bet_type')
      bet_type = BetType.find_or_create_by(name: params[:bet][:bet_type])
      params[:bet].delete('bet_type')
      params[:bet][:bet_type_id] = bet_type.id
    end

    if params[:bet].has_key?('bookmaker')
      bookmaker = Bookmaker.find_by(name: params[:bet][:bookmaker])
      params[:bet].delete('bookmaker')
      params[:bet][:bookmaker_id] = bookmaker.id
    else
      params[:bet][:bookmaker_id] = Bookmaker.other_id
    end
  end
end
