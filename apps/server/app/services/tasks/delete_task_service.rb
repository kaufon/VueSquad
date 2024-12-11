module Tasks
  class DeleteTaskService
    class NotOwner < StandardError
    end

    class NotInSquad < StandardError
    end

    def initialize(task, current_user)
      @user = current_user
      @task = task
    end

    def execute
      raise NotInSquad, "User not in squad" unless @task.squad.users.include?(@user)
      raise NotOwner, "Incorrect Owner" if @user != @task.creator_id
      @task.destroy
    end
  end
end
