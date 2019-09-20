# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # TODO: add auth helper and other methods
  describe 'GET /api/users' do
    context 'with an unauthenticated user' do
      it 'returns unauthorized' do
        get '/api/users'
        expect(response).to be_unauthorized
      end
    end

    context 'with an authenticated user' do
      let(:user) { create(:user) }

      it 'renders json listing resource with id' do
        get '/api/users', headers: authentication_header(user)

        expect(response).to have_http_status(200)
        expect(json.first['email']).not_to be_empty
      end
    end
  end

  describe 'POST /api/users/create' do
    subject! { post '/api/users', params: params }

    context 'when the request is valid' do
      let(:params) do
        { email: 'test@test.com', password: 'password', password_confirmation: 'password' }
      end

      it 'creates user' do
        expect(response).to have_http_status(201)
        # TODO: maybe i dont have to share this information
        expect(json['password_digest']).not_to be_empty
      end
    end

    context 'when the request is invalid' do
      let(:params) { {} }

      it 'returns a validation failure message' do
        expect(response).to have_http_status(422)
        expect(json['errors']).not_to be_empty
      end
    end
  end

  describe 'POST /api/user/:id update' do
    let(:user) { create(:user) }
    subject! { patch "/api/users/#{user.id}", params: params, headers: headers }

    context 'with an unauthenticated user' do
      let(:params) { {} }

      it 'returns unauthorized' do
        expect(response).to be_unauthorized
      end
    end

    context 'with an authenticated user and valid params' do
      let(:headers) { authentication_header(user) }
      let(:params) do
        { email: 'test@test.com', password: '123456', password_confirmation: '123456' }
      end

      it 'renders json listing resource with id' do
        expect(response).to have_http_status(200)
        expect(json['email']).to eq 'test@test.com'
      end
    end

    context 'with an authenticated user and invalid params' do
      let(:headers) { authentication_header(user) }
      let(:params) do
        { email: 'asd' }
      end

      it 'returns record invalid' do
        expect(response).to have_http_status(422)
        expect(json['errors']).to eq 'Validation failed: Email is invalid'
      end
    end

    context 'unprivileged user tries to update not himself' do
      let(:another_user) { create(:user) }
      let(:headers) { authentication_header(another_user) }
      let(:params) do
        { email: 'test@test.com', password: '123456', password_confirmation: '123456' }
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(401)
        expect(json['errors']).to eq 'Unauthorized'
      end
    end
  end

  describe 'GET /api/users/show' do
    subject! { get '/api/users/show', headers: headers }

    context 'without authorization' do
      it 'returns unauthorized' do
        expect(response).to be_unauthorized
      end
    end

    context 'with an authenticated user' do
      let(:user) { create(:user) }
      let(:headers) { authentication_header(user) }

      it 'renders json listing resource with id' do
        expect(response).to have_http_status(200)
        expect(json['email']).not_to be_empty
      end
    end
  end

  describe 'DELETE /api/user/:id #destroy' do
    let(:user) { create(:user) }
    subject! { delete "/api/users/#{user.id}", headers: headers }

    context 'with an unauthenticated user' do
      it 'returns unauthorized' do
        expect(response).to be_unauthorized
      end
    end

    context 'with an authenticated user and valid params' do
      let(:headers) { authentication_header(user) }

      it 'renders status 204 and empty body' do
        expect(response).to have_http_status(204)
        expect(response.body).to be_empty
      end
    end

    context 'unprivileged user tries to delete not himself' do
      let(:another_user) { build(:user) }
      let(:headers) { authentication_header(another_user) }

      it 'returns unauthorized' do
        expect(response).to have_http_status(401)
        expect(json['errors']).to eq 'Unauthorized'
      end
    end
  end
end
