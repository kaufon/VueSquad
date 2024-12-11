module Squads
  class UpdateSquadService
    def initialize(squad, params, current_user)
      @squad = squad
      @params = params
      @current_user = current_user
    end

    def execute
      unless @squad.owner_id == @current_user.id
        raise StandardError, "User must be owner of squad"
      end

      @squad.update(@params)
      @squad
    end
  end
end
