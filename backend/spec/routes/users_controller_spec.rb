# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :routing do
  it { is_expected.to route(:post, "/api/users").to("users#create", {}) }
  it { is_expected.to route(:get, "/api/users/1").to("users#show", id: "1") }
  it { is_expected.to route(:get, "/api/users").to("users#index", {}) }
  it { is_expected.to route(:delete, "/api/users/1").to("users#destroy", id: "1") }
  it { is_expected.to route(:patch, "/api/users/1").to("users#update", id: "1") }
end
