class SquadsController < ApplicationController
  skip_before_action :authenticate_request, only: [ :index ]
  def create
    @squad = Squad.new(squad_params.merge(owner_id: current_user.id))
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

    if @squad.nil?
      render(json: { message: "Squad not found" }, status: :unprocessable_entity) and return
    end

    unless current_user.id == @squad.owner_id
      render(json: { message: "You are not the owner of this squad" }, status: :unprocessable_entity) and return
    end

    @user_squad = SquadsUsers.new(add_params)

    if @user_squad.save
      render(json: @user_squad, status: :created)
    else
      render(json: @user_squad.errors, status: :unprocessable_entity)
    end
  end

  def remove
    @squad = Squad.find_by_id(add_params[:squad_id])
    if @squad.nil?
      render(json: { message: "Squad not found" }, status: :unprocessable_entity) and return
    end

    unless current_user.id == @squad.owner_id
      render(json: { message: "You are not the owner of this squad" }, status: :unprocessable_entity) and return
    end

    @user = User.find_by_id(add_params[:user_id])
    if @user.nil?
      render(json: { message: "User not found" }, status: :unprocessable_entity) and return
    end

    @squad.users.delete(@user)
    render(json: { message: "User removed successfully" }, status: :ok)
  end

  def destroy
    @squad = Squad.find(params[:id])
    if @squad.nil?
      render(json: { message: "Squad not found" }, status: :unprocessable_entity) and return
    end

    if @squad.owner_id != current_user.id
      render(json: { message: "You are not the owner of this squad" }, status: :unprocessable_entity) and return
    end

    @squad.destroy
    render(json: { message: "Squad deleted successfully" }, status: :ok)
  end

  private
  def squad_params
    params.permit([ :name, :owner_id ])
  end

  def add_params
    params.permit([ :user_id, :squad_id ])
  end
end
