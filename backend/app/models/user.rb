# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # TODO: add validations
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, length: {minimum: 6, maximum: 40},
                       if: -> { new_record? || password.present? }

  # https://engineering.musefind.com/building-a-simple-token-based-authorization-api-with-rails-a5c181b83e02
  # This method gives us a simple call to check if a user has permission to modify.
  def can_modify_user?(user_id)
    id.to_s == user_id.to_s
  end
end
