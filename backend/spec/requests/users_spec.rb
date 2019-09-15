# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /api/users/create' do
    subject! { post '/api/users/create', params: params }

    context 'when the request is valid' do
      let(:params) do
        { email: 'test@test.com', password: 'password', password_confirmation: 'password' }
      end

      it 'creates user' do
        # TODO: maybe i dont have to share this information
        expect(json['password_digest']).not_to be_empty
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:params) { {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['errors']).not_to be_empty
      end
    end
  end

  # TODO: add auth helper and other methods
end
