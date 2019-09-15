# frozen_string_literal: true

class UsersController < ApplicationController
  # Use Knock to make sure the current_user is authenticated before completing request.
  before_action :authenticate_user,  only: [:index, :whoami, :update]
  before_action :authorize,          only: [:update, :destroy]

  def index
    json_response(User.all)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      json_response(@user, :created)
    else
      record_invalid
    end
  end

  def update
    @user = User.find(params[:id])
    if user.update(user_params)
      json_response(@user)
    else
      record_invalid
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      head :no_content
    else
      record_invalid
    end
  end

  def whoami
    json_response(current_user)
  end

  private

  # Setting up strict parameters for when we add account creation.
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  # Adding a method to check if current_user can update itself.
  # This uses our UserModel method.
  def authorize
    unauthorized unless current_user&.can_modify_user?(params[:id])
  end
end
