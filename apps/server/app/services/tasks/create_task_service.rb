module Tasks
  class CreateTaskService
    def initialize(params, users, current_user)
      @params = params
      @users = users
      @current_user = current_user
    end

    def execute
      ActiveRecord::Base.transaction do
        task = Task.new(@params.except(:users).merge(creator_id: @current_user.id))
        unless task.squad.users.include?(@current_user) || task.squad.owner_id == @current_user.id
          raise StandardError, "User must be in squad"
        end

        raise ActiveRecord::Rollback unless task.save
        if @users
          @users.each do |user|
            tasks_user = TasksUser.new(task_id: task.id, user_id: user[:id])

            unless tasks_user.save
              raise StandardError, tasks_user.errors.full_messages.join(" , ")
            end
          end
        end

        task.to_json(include: { users: { only: [ :id, :name ] } })
      end
    end
  end
end
