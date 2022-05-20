class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authorize_task

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(get_task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:notice] = "Task successfully created"
      redirect_to @task
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(get_task_params)
      flash[:notice] = "Task successfully edited"
      redirect_to @task
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "Task successfully deleted"
    redirect_to tasks_path, status: :see_other
  end

  private

  def get_task_params
    params.require(:task).permit(:title, :description)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def authorize_task
    authorize(@task || Task)
  end
end
