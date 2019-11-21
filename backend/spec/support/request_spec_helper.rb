# frozen_string_literal: true

# Helpers for request tests. Handle auth and json parsing
module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def authentication_header(user)
    {'Authorization': "Bearer #{generate_token_for_user_and_return_value(user)}"}
  end

  private

  def generate_token_for_user_and_return_value(user)
    KnockKnock::AuthToken.new(payload: {sub: user.id}).token
  end
end
