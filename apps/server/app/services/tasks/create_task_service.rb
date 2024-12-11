module Tasks
  class CreateTaskService
    def initialize(params, users, current_user)
      @params = params
      @users = users
      @current_user_id = current_user.id
    end

    def execute
      ActiveRecord::Base.transaction do
        task = Task.new(@params.except(:users).merge(creator_id: @current_user_id))

        raise ActiveRecord::Rollback unless task.save

        @users.each do |user|
          tasks_user = TasksUser.new(task_id: task.id, user_id: user[:id])

          unless tasks_user.save
            raise StandardError, tasks_user.errors.full_messages.join(" , ")
          end
        end

        task.to_json(include: { users: { only: [ :id, :name ] } })
      end
    end
  end
end
