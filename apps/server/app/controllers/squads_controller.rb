class SquadsController < ApplicationController
  before_action :set_squad, only: %i[update]
  def create
    @squad = Squad.new(squad_params.merge(owner_id: current_user.id))
    if @squad.save
      render(json: @squad, status: :created, location: @squad)
    else
      render(json: @squad.errors, status: :unprocessable_entity)
    end
  end

  def update
    unless @squad
      render(json: { message: "squad not found" }, status: :not_found) and return
    end

    service = Squads::UpdateSquadService.new(@squad, squad_params, current_user)
    response = service.execute
    render(json: response)
  end

  def index
    squads_user_is_owner = Squad.includes(:users).where(owner_id: current_user.id)
    squads_user_is_participant = Squad.includes(:users).where(users: { id: current_user.id })
    squads = squads_user_is_owner.or(squads_user_is_participant)
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
  def set_squad
    @squad = Squad.find_by(id: params[:id])
  end

  def squad_params
    params.permit([ :name ])
  end

  def add_params
    params.permit([ :user_id, :squad_id ])
  end
end
