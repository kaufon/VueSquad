module Squads
  class RemoveUserFromSquadService
    class SquadNotFoundError < StandardError
    end

    class NotOwnerError < StandardError
    end

    class SaveError < StandardError
    end

    class UserNotFound < StandardError
    end

    class UserNotInSquad < StandardError
    end

    def initialize(params, current_user)
      @params = params
      @current_user_id = current_user.id
    end

    def execute
      squad = Squad.find_by_id(@params[:squad_id])
      raise SquadNotFoundError, "Squad not Found" unless squad

      raise NotOwnerError, "Incorrect Owner" unless @current_user_id == squad.owner_id

      user = User.find_by_id(@params[:user_id])
      raise UserNotFound, "User not Found" unless user
      raise UserNotInSquad, "User not in Squad" unless squad.users.include?(user)
      squad.users.delete(user)
    end
  end
end
