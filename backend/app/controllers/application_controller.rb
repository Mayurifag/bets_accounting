# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include Knock::Authenticable
  include Pagy::Backend
  # before_action :authorize_request
end
