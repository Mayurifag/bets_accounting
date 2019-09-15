# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request, skip: true do
  # Create user
  describe 'POST /api/users' do
    let(:valid_attributes) do
      {
        email: 'test@test.com',
        username: 'test',
        password: 'password',
        password_confirmation: 'password'
      }
    end

    context 'when the request is valid' do
      before { post '/api/users', params: valid_attributes }

      it 'creates user' do
        expect(json['password_digest']).not_to be_empty
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/users', params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/can't be blank/)
      end
    end
  end

  # TODO: add auth helper and other methods
end
