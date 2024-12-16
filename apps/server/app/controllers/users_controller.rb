class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create index]
  before_action :set_user, only: %i[show destroy update]
  def index
    users = User.all
    @users = users.then(&paginate)
    render(json: @users)
  end

  def show
    render(json: current_user)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render(json: @user, status: :created, location: @user)
    else
      render(json: @user.errors, status: :unprocessable_entity)
    end
  end

  def update
    unless @user
      render(json: { message: "user not found" }, status: :not_found) and return
    end

    if @user.update(user_params)
      render(json: @user)
    else
      render(json: @user.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    unless @user
      render(json: { message: "user not found" }, status: :not_found) and return
    end

    @user.destroy!
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.permit([ :name, :email, :password, :password_confirmation ])
  end
end
