# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bet, type: :model do
  # TODO: test profit calculation
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :bet_type_id }
  it { is_expected.to have_db_column :bookmaker_id }
  it { is_expected.to have_db_column :choice1_id }
  it { is_expected.to have_db_column :choice2_id }
  it { is_expected.to have_db_column :coefficient }
  it { is_expected.to have_db_column :comment }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :discipline_id }
  it { is_expected.to have_db_column :event_id }
  it { is_expected.to have_db_column :outcome }
  it { is_expected.to have_db_column :profit }
  it { is_expected.to have_db_column :result_variant_id }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :wager }

  it { is_expected.to have_db_index %w[bet_type_id] }
  it { is_expected.to have_db_index %w[bookmaker_id] }
  it { is_expected.to have_db_index %w[choice1_id] }
  it { is_expected.to have_db_index %w[choice2_id] }
  it { is_expected.to have_db_index %w[created_at] }
  it { is_expected.to have_db_index %w[discipline_id] }
  it { is_expected.to have_db_index %w[event_id] }
  it { is_expected.to have_db_index %w[result_variant_id] }

  it { is_expected.to validate_numericality_of(:wager).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:coefficient).is_greater_than_or_equal_to(1.0) }
end
