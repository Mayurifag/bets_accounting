require 'rails_helper'

RSpec.describe 'Bets API', type: :request do
  # initialize test data
  let!(:bets) { create_list(:bet, 10) }
  let(:bet_id) { bets.first.id }

  # Test suite for GET /bets
  describe 'GET /api/bets' do
    # make HTTP get request before each example
    before { get '/api/bets' }

    it 'returns bets' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /bets/:id
  describe 'GET /bets/:id' do
    before { get "/api/bets/#{bet_id}" }

    context 'when the record exists' do
      it 'returns the bet' do
        expect(json).not_to be_empty
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
    let(:discipline_id) { discipline.id }
    let(:result_variant_id) { result_variant.id }
    let(:coefficient) { 1.43 }
    let(:valid_attributes) do
      { discipline_id: discipline_id,
        result_variant_id: result_variant_id,
        coefficient: coefficient,
        wager: 10_000,
        outcome: 'П1' }
    end

    context 'when the request is valid' do
      before { post '/api/bets', params: valid_attributes }

      it 'creates a todo' do
        expect(json['coefficient']).to eq(coefficient)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/bets', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed/)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /api/bets/:id' do
    # TODO: check profit countability
    let(:valid_attributes) { { coefficient: 1.46 } }

    context 'when the record exists' do
      before { put "/api/bets/#{bet_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /bets/:id' do
    before { delete "/api/bets/#{bet_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
