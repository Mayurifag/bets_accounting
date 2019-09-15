# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6, maximum: 40 },
            if: -> { new_record? || password.present? }

  # https://engineering.musefind.com/building-a-simple-token-based-authorization-api-with-rails-a5c181b83e02
  # This method gives us a simple call to check if a user has permission to modify.
  def can_modify_user?(user_id)
    id.to_s == user_id.to_s
  end
end
