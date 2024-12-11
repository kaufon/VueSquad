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
    squads = Squad.includes(:users).all
    squads = squads.then(&paginate)
    @squads = squads.to_json(include: { users: { only: [ :id, :name, :email ] } })
    render(json: @squads)
  end

  def add
    service = Squads::AddUserToSquadService.new(add_params, current_user)
    response = service.execute
    render(json: response)
  end

  def remove
    service = Squads::RemoveUserFromSquadService.new(add_params, current_user)
    service.execute
    render(json: { message: "User removed successfully" })
  end

  def destroy
    service = Squads::DeleteSquadService.new(params[:id], current_user)
    service.execute
    render(json: { message: "Squad Deleted successfully" })
  end

  private
  def squad_params
    params.permit([ :name])
  end

  def add_params
    params.permit([ :user_id, :squad_id ])
  end
end
