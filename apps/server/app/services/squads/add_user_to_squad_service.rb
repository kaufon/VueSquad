module Squads
  class AddUserToSquadService
    class SquadNotFoundError < StandardError
    end

    class NotOwnerError < StandardError
    end

    class SaveError < StandardError
    end

    def initialize(params, current_user)
      @params = params
      @current_user_id = current_user.id
    end

    def execute
      squad = Squad.find_by_id(@params[:squad_id])
      raise SquadNotFoundError, "Squad not Found" if squad.nil?

      raise NotOwnerError, "Incorrect Owner" unless @current_user_id == squad.owner_id

      squad_user = SquadsUsers.new(@params)
      raise SaveError, squad_user.errors.full_messages.join(" , ") unless squad_user.save

      squad_user
    end
  end
end
