# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, except: %i[create index]
  # skip_before_action :authorize_request, only: %i[create]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    return if @user.update(user_params)

    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by!(username: params[:_username])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :username, :email, :password, :password_confirmation
    )
  end
end
