# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /api/auth' do
    let!(:user) { create :user }

    subject! { post '/api/auth', params: params }

    context 'when the request is valid' do
      let(:params) { { email: user.email, password: user.password } }

      it 'creates user' do
        expect(json['jwt']).not_to be_empty
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the password is wrong' do
      let(:params) { { email: user.email, password: 'wrong_pass' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to eq 'Record invalid'
      end
    end
  end
end
