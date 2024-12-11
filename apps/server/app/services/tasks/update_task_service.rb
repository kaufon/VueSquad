module Tasks
  class UpdateTaskService
    class UserNotInSquad < StandardError
    end

    def initialize(task, params, current_user)
      @task = task
      @params = params
      @current_user = current_user
    end

    def execute
      ActiveRecord::Base.transaction do
        raise UserNotInSquad, "User must be in squad" unless @task.squad.users.include?(@current_user) || @task.squad.owner_id == @current_user.id
        @task.update(@params.except(:users))
        if @params[:users]
          update_task_users(@params[:users])
        end
      end

      @task
    end

    private
    def update_task_users(users)
      @task.users.clear
      users.each do |user|
        tasks_user = TasksUser.new(task_id: @task.id, user_id: user[:id])
        unless tasks_user.save
          raise StandardError, tasks_user.errors.full_messages.join(" , ")
        end
      end
    end
  end
end
