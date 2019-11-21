# frozen_string_literal: true

# All the exceptions from application had to be handled here with jsons or whatever
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

    rescue_from ActiveRecord::RecordNotFound do |exception|
      not_found(exception.message)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      record_invalid(exception.message)
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
