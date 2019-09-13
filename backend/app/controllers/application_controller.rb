# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  # before_action :authorize_request

  # TODO: rewrite
  # maybe take from https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-two#toc-authorize-api-request
  def authorize_request
    header = request.headers['Authorization']&.split(' ')&.last
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => error
      unauthorized(error.message)
    rescue JWT::DecodeError => error
      unauthorized(error.message)
    end
  end
end
