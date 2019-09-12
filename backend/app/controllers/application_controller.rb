# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  # before_action :authorize_request

  # include ActionController::MimeResponds
  # respond_to :json

  # TODO: json response and ExceptionHandler
  def unauthorized
    render json: { error: 'unauthorized' }, status: :unauthorized
  end

  def record_invalid(message)
    render json: { error: message }, status: :unprocessable_entity
  end

  # TODO: rewrite
  # maybe take from https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-two#toc-authorize-api-request
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
