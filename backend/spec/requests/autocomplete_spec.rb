# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Autocomplete', type: :request do
  before do
    create(:bookmaker, name: '1huibet')
    create(:bookmaker, name: '1huibetsad')
  end

  subject! { post '/api/autocomplete', params: params }

  context 'when query is valid for permitted class' do
    let(:params) { {class_name: 'Bookmaker', query: '1hui'} }

    it 'returns autocompleted ordered hash' do
      expect(response).to have_http_status(200)
      expect(json.first['name']).to eq('1huibet')
      expect(json.second['name']).to eq('1huibetsad')
    end
  end

  context 'when query is valid for unpermitted class' do
    let(:params) { {class_name: 'ResultVariant', query: 'Победа'} }

    it 'returns error' do
      expect(response).to have_http_status(422)
      expect(json['errors']).to eq('Unpermitted class name ResultVariant')
    end
  end
end
