# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FactoryBotRails do
  it 'is possible to use all factories' do
    FactoryBot.lint
  end
end
