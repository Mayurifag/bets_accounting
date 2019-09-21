# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Autocomplete', type: :request do
  let!(:bookmaker) { create(:bookmaker, name: '1huibet') }
  let!(:bookmaker2) { create(:bookmaker, name: '1huibetsad') }

  subject! { post '/api/autocomplete', params: params }

  context 'should work for bookmaker' do
    let(:params) { { class_name: 'Bookmaker', query: '1hui' } }

    it 'should return autocomplete hash' do
      expect(response).to have_http_status(200)
      expect(json.first['name']).to eq('1huibet')
      expect(json.second['name']).to eq('1huibetsad')
    end
  end

  context 'shouldnt work for unpermitted class names' do
    let(:params) { { class_name: 'ResultVariant', query: 'Победа' } }

    it 'should return error' do
      expect(response).to have_http_status(422)
      expect(json['errors']).to eq('Unpermitted class name ResultVariant')
    end
  end
end
