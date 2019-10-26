# frozen_string_literal: true

class UsersController < ApplicationController
  # Use Knock to make sure the current_user is authenticated before completing request.
  before_action :authenticate_user, only: %i[index show update]
  before_action :authorize, only: %i[update destroy]

  def index
    # TODO: no need / blueprint
    json_response(User.all)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      head :created
    else
      record_invalid
    end
  end

  def update
    # TODO: validations on update -- what to update
    @user = User.find(params[:id])
    json_response(@user) if @user.update!(user_params)
  end

  def destroy
    @user = User.find(params[:id])
    head :no_content if @user.destroy!
  end

  def show
    json_response(current_user)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def authorize
    unauthorized unless current_user&.can_modify_user?(params[:id])
  end
end
