# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Autocomplete', type: :request do
  context 'should work for bookmaker' do
    let!(:bookmaker) { create(:bookmaker, name: '1huibet') }

    before { post '/api/autocomplete', params: { class_name: 'Bookmaker', query: '1hui' } }

    it 'should return autocomplete hash' do
      expect(response).to have_http_status(200)
      expect(response.body).to match(/1huibet/)
    end
  end

  context 'shouldnt work for unpermitted class names' do
    before { post '/api/autocomplete', params: { class_name: 'ResultVariant', query: 'Победа' } }

    it 'should return error' do
      expect(response).to have_http_status(422)
      expect(response.body['error']).to match(/Unpermitted class name ResultVariant/)
    end
  end
end
