# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: %i[login]

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      render_login_token_json
    else
      unauthorized
    end
  end

  private

  def render_login_token_json
    token = JsonWebToken.encode(user_id: @user.id)
    time = Time.now + 24.hours.to_i
    render json: { token: token,
                   exp: time.strftime('%d.%m.%Y %H:%M'),
                   username: @user.username }, status: :ok
  end

  def login_params
    params.permit(:email, :password)
  end
end
