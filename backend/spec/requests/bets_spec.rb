# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bets API', type: :request do
  let(:coefficient) { 2.28 }

  # Test suite for GET /bets
  describe 'GET /api/bets' do
    context 'without any params' do
      let!(:bets) { create_list(:bet, 2) }
      before { get '/api/bets' }

      it 'returns bets' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    # TODO: make this better
    context 'dumb specs for autocomplete' do
      %w[bookmakers disciplines events participants].each do |param|
        it 'returns status code 200 and empty if not exist' do
          get "/api/bets?autocomplete_#{param}=qasdasdasdasdasdasdasd"

          expect(response).to have_http_status(200)
          expect(json).to be_empty
        end
      end
    end
  end

  # Test suite for GET /bets/:id
  describe 'GET /bets/:id' do
    let!(:bets) { create_list(:bet, 2) }
    let(:bet_id) { bets.first.id }
    before { get "/api/bets/#{bet_id}" }

    context 'when the record exists' do
      it 'returns the bet' do
        expect(json['id']).to eq(bet_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:bet_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bet/)
      end
    end
  end

  # Test suite for POST /bets
  describe 'POST /api/bets' do
    # TODO: test profit calculation
    let!(:discipline) { create(:discipline) }
    let!(:result_variant) { create(:result_variant) }
    let!(:choice1) { create(:participant) }
    let!(:choice2) { create(:participant) }
    let(:choice1_id) { choice1.id }
    let(:choice2_id) { choice2.id }
    let(:discipline_id) { discipline.id }
    let(:result_variant_id) { result_variant.id }
    let(:valid_attributes) do
      { bet: { choice1_id: choice1_id,
               choice2_id: choice2_id,
               discipline_id: discipline_id,
               result_variant_id: result_variant_id,
               coefficient: coefficient,
               wager: 10_000,
               outcome: 'П1' } }
    end
    let(:params_to_be_transformed) do
      { bet:
        { choice1: 'test',
          choice2: 'test',
          discipline: 'test disc',
          result_variant_id: 'result var',
          bet_type: 'asd',
          coefficient: coefficient,
          wager: 10_000,
          outcome: 'П1',
          bookmaker: '1huybet' } }
    end

    context 'when the request is valid' do
      before { post '/api/bets', params: valid_attributes }

      it 'creates a bet' do
        expect(json['coefficient']).to eq(coefficient)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is fully invalid' do
      before { post '/api/bets', params: { bet: { title: 'Foobar' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/must exist/)
      end
    end

    # TODO: make this better: expect to create etc.
    context 'when params have to be transformed' do
      before { post '/api/bets', params: params_to_be_transformed }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'updates discipline and creates it' do
        expect(json['discipline']).to eq 'test disc'
      end
    end
  end

  # Test suite for PUT /bets/:id
  describe 'PUT /api/bets/:id' do
    let!(:bet) { create :bet }
    let(:bet_id) { bet.id }
    let(:params) do
      { bet: { coefficient: coefficient, wager: 1000, result_variant_id: 2 } }
    end

    context 'when the record exists' do
      before { put "/api/bets/#{bet_id}", params: params }

      it 'updates record and profit column with lose' do
        expect(json['profit']).to eq '-1000.00'
      end
    end

    context 'when the coefficient is invalid' do
      let(:params) do
        { bet: { id: bet_id, coefficient: 'asd' } }
      end

      before { put "/api/bets/#{bet_id}", params: params }

      it 'returns status code 422' do
        expect(response.body).not_to be_empty
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
