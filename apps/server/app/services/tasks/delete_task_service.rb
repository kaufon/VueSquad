module Tasks
  class DeleteTaskService
    class NotOwner < StandardError
    end


    def initialize(task, current_user)
      @user = current_user
      @task = task
    end

    def execute
      raise NotOwner, "Incorrect Owner" if @user.id != @task.creator_id
      @task.destroy
    end
  end
end
