# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Generator, type: :model do
  before { create :participant }

  # Look at ActiveRecordExtension memoization
  after { Participant.public_send(:remove_instance_variable, :@_ids) }

  describe '#generate_bets' do
    it 'has to create paramed integer number of bets' do
      expect { described_class.generate_bets(2) }.to change { Bet.count }.from(0).to(2)
    end

    it 'still has to create a bet if something wrong typed as param' do
      expect { described_class.generate_bets(-32) }.to change { Bet.count }.from(0).to(1)
    end
  end
end
