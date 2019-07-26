# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request

  # include ActionController::MimeResponds
  # respond_to :json

  def not_found
    render json: { error: 'not_found' }, status: :unprocessable_entity
  end

  def unauthorized
    render json: { error: 'unauthorized' }, status: :unauthorized
  end

  # TODO: rewrite
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
