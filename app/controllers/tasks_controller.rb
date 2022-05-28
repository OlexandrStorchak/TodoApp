class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authorize_task

  def index
    @pagy, @tasks = pagy(fetch_tasks_service[:tasks])
    flash.now[:notice] = fetch_tasks_service[:msg] if fetch_tasks_service[:msg].present?
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.merge({ user_id: current_user.id }))
    if @task.save
      flash[:notice] = 'Task successfully created'
      redirect_to @task
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    redirect_to_all_tasks if @task.nil?
  end

  def edit
    redirect_to_all_tasks if @task.nil?
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task successfully edited'
      redirect_to @task
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = 'Task successfully deleted'
    redirect_to tasks_path, status: :see_other
  end

  private

  def fetch_tasks_service
    Tasks::TasksFetchService.new(current_user, params).call
  end

  def redirect_to_all_tasks
    redirect_to tasks_path
    flash[:alert] = 'Task not exist'
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def authorize_task
    authorize(@task || Task.new)
  end
end
