module Squads
  class DeleteSquadService
    class SquadNotFound < StandardError
    end

    class NotOwner < StandardError
    end

    def initialize(id, current_user)
      @id = id
      @current_user_id = current_user.id
    end

    def execute
      squad = Squad.find_by_id(@id)
      raise SquadNotFound, "Squad not found" if squad.nil?
      raise NotOwner, "Incorrect Owner" if @current_user_id != squad.owner_id
      squad.destroy
    end
  end
end
