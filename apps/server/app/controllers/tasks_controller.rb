class TasksController < ApplicationController
  before_action :set_task, only: %i[destroy show update]
  def index
    squad_id = params[:squad_id]
    if squad_id.present?
      @tasks = Task.includes(:users).where(squad_id: squad_id)
    else
      @tasks = Task.includes(:users).all
    end

    tasks = @tasks.then(&paginate)
    tasks = tasks.to_json(include: { users: { only: [ :id, :name ] } })
    render(json: tasks)
  end

  def create
    service = Tasks::CreateTaskService.new(task_params, task_params[:users], current_user)
    response = service.execute
    render(json: response)
  end

  def destroy
    service = Tasks::DeleteTaskService.new(@task, current_user)
    service.execute
    render(json: { message: "Task deleted sucessfuly" })
  end

  def update
    service = Tasks::UpdateTaskService.new(@task, task_params, current_user)
    service.execute
    render(json: { message: "Task edited sucessfuly" })
  end

  def show
    render(json: @task, status: :ok)
  end

  private
  def task_params
    params.permit([ :name, :deadline, :description, :status, :todo, :squad_id, :priority, :size, users: [ :id ] ])
  end

  def set_task
    @task = Task.find(params.expect(:id))
  end
end
