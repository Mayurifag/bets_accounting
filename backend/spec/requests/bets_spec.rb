# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bets API', type: :request do
  # Test suite for GET /bets
  describe 'GET /api/bets' do
    context 'without any params' do
      before { create_list(:bet, 2) }

      it 'returns bets' do
        get '/api/bets'

        expect(json).not_to be_empty
        expect(json.size).to eq(2)
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for GET /bets/:id
  describe 'GET /bets/:id' do
    let(:bet) { create :bet }

    before { get "/api/bets/#{bet_id}" }

    context 'when the record exists' do
      let(:bet_id) { bet.id }

      it 'returns the bet' do
        expect(response).to have_http_status(200)
        expect(json['id']).to eq(bet_id)
      end
    end

    context 'when the record does not exist' do
      let(:bet_id) { -1 }

      it 'returns a not found message' do
        expect(response).to have_http_status(404)
        expect(response.body).to match(%r{Couldn't find Bet})
      end
    end
  end

  # Test suite for POST /bets
  describe 'POST /api/bets' do
    let(:coefficient) { 2.28 }
    let!(:result_variant) { ResultVariant.create(id: 1, name: 'Победа') }

    context 'when the request is valid' do
      let!(:discipline) { build(:discipline) }
      let!(:choice) { create(:participant) }
      let(:valid_attributes) do
        { bet: { choice1_id: choice.id, choice2_id: choice.id, discipline_id: discipline.id,
                 result_variant_id: result_variant.id, coefficient: coefficient, wager: 10_000,
                 outcome: 'П1' }}
      end

      before do
        create(:bet_type, name: 'Лайв')
        post '/api/bets', params: valid_attributes
      end

      it 'creates a bet' do
        expect(json['coefficient']).to eq(coefficient)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is fully invalid' do
      before { post '/api/bets', params: { bet: { title: 'Foobar' }} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(%r{must exist})
      end
    end

    context 'when params have to be transformed' do
      let(:params_to_be_transformed) do
        { bet: { choice1: 'fuck specs', choice2: 'fuck specs', discipline: 'test disc',
                 result_variant: 'Победа', bet_type: 'Лайв', coefficient: coefficient,
                 wager: 10_000, outcome: 'П1', bookmaker: '1huybet' }}
      end

      before { post '/api/bets', params: params_to_be_transformed }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'updates discipline and creates it' do
        expect(json['discipline']).to eq 'test disc'
      end

      it 'creates participant for choices' do
        expect(json['choice1']).to eq json['choice2']
        expect(Bet.first.choice1_id).to eq Bet.first.choice2_id
      end

      it 'finds result_variant_id' do
        expect(Bet.first.result_variant_id).to eq ResultVariant.win_id
      end
    end
  end

  # Test suite for PUT /bets/:id
  describe 'PUT /api/bets/:id' do
    let(:coefficient) { 2.28 }
    let!(:bet) { create :bet }
    let(:bet_id) { bet.id }
    let(:params) do
      { bet: { coefficient: coefficient, wager: 1000, result_variant_id: 2 }}
    end

    before { put "/api/bets/#{bet_id}", params: params }

    context 'when the record exists' do
      it 'updates record and profit column with lose' do
        expect(json['profit']).to eq '-1000.00'
      end
    end

    context 'when the coefficient is invalid' do
      let(:params) do
        { bet: { id: bet_id, coefficient: 'asd' }}
      end

      it 'returns status code 422' do
        expect(json).not_to be_empty
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for DELETE /bets/:id
  describe 'DELETE /bets/:id' do
    let!(:bet) { create(:bet) }
    let(:bet_id) { bet.id }

    before { delete "/api/bets/#{bet_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
