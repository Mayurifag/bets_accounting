# frozen_string_literal: true

require "rails_helper"

RSpec.describe AutocompleteController, type: :routing do
  it { is_expected.to route(:post, "/api/autocomplete").to("autocomplete#search", {}) }
end
