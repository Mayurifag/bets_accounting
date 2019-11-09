# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  # class AuthenticationError < StandardError; end
  # class MissingToken < StandardError; end
  # class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    # rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized
    # rescue_from ExceptionHandler::MissingToken, with: :record_invalid
    # rescue_from ExceptionHandler::InvalidToken, with: :record_invalid

    rescue_from ActiveRecord::RecordNotFound do |e|
      not_found(e.message)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      record_invalid(e.message)
    end
  end

  def unauthorized(message = "Unauthorized")
    json_response({errors: message}, :unauthorized)
  end

  def record_invalid(message = "Record invalid")
    json_response({errors: message}, :unprocessable_entity)
  end

  def not_found(message = "Not found")
    json_response({errors: message}, :not_found)
  end
end
