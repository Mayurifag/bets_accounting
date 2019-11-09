# frozen_string_literal: true

require "spec_helper"

RSpec.describe Event, type: :model do
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :name }
  it { is_expected.to have_db_column :period }
  it { is_expected.to have_db_column :updated_at }

  it { is_expected.to have_db_index %w[name] }

  it { is_expected.to validate_presence_of :name }
end
