# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BetsController, type: :routing do
  it { is_expected.to route(:post, '/api/bets').to('bets#create', {}) }
  it { is_expected.to route(:get, '/api/bets/1').to('bets#show', id: '1') }
  it { is_expected.to route(:get, '/api/bets').to('bets#index', {}) }
  it { is_expected.to route(:delete, '/api/bets/1').to('bets#destroy', id: '1') }
  it { is_expected.to route(:patch, '/api/bets/1').to('bets#update', id: '1') }
end
