# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include Knock::Authenticable
  # before_action :authorize_request
end
