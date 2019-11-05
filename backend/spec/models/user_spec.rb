# frozen_string_literal: true

require 'spec_helper'

RSpec.describe User, model: :type do
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :email }
  it { is_expected.to have_db_column :password_digest }
  it { is_expected.to have_db_column :updated_at }

  it { is_expected.to have_db_index %w[email] }

  # TODO: validations
  it { is_expected.to validate_presence_of :email }
end
