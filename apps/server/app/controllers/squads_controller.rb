class SquadsController < ApplicationController
  skip_before_action :authenticate_request, only: [ :create, :add, :remove, :index, :destroy ]
  def create
    @squad = Squad.new(squad_params)
    if @squad.save
      render(json: @squad, status: :created, location: @squad)
    else
      render(json: @squad.erros, status: :unprocessable_entity)
    end
  end

  def index
    @squads = Squad.includes(:users).all
    render(json: @squads.to_json(include: { users: { only: [ :id, :name, :email ] } }))
  end

  def add
    @squad = Squad.find_by_id(add_params[:squad_id])
    if @squad
      @user_squad = SquadsUsers.new(add_params)
      if @user_squad.save
        render(json: @user_squad, status: :created)
      else
        render(json: @user_squad.errors, status: :unprocessable_entity)
      end
    else
      render(json: { message: "squad not found" }, status: :unprocessable_entity)
    end
  end

  def remove
    @squad = Squad.find_by_id(add_params[:squad_id])
    if @squad
      @user = User.find_by_id(add_params[:user_id])
      if @user
        if @squad.users.include?(@user)
          @squad.users.delete(@user)
          render(json: { message: "User removed from squad" }, status: :ok)
        else
          render(json: { message: "User not in  squad" }, status: :unprocessable_entity)
        end
      else
        render(json: { message: "User not found" }, status: :unprocessable_entity)
      end
    else
      render(json: { message: "squad not found" }, status: :unprocessable_entity)
    end
  end

  def destroy
    @squad = Squad.find(params[:id])
    if @squad.destroy
      render(json: { message: "Squad deleted successfully" }, status: :ok)
    else
      render(json: { message: "Failed to delete squad" }, status: :unprocessable_entity)
    end
  end

  private
  def squad_params
    params.permit([ :name, :owner_id ])
  end

  def add_params
    params.permit([ :user_id, :squad_id ])
  end
end
