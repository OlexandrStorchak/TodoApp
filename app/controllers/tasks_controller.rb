class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authorize_task

  def index
    @pagy, @tasks = pagy(current_user.tasks.all) if current_user.present?
    @pagy, @tasks = pagy(Task.all) if params[:all_users].present? && current_user.admin?
    @pagy, @tasks = pagy(current_user.tasks.order(status: params[:sort_status])) if params[:sort_status].present? && current_user.present?
    @pagy, @tasks = pagy(Task.filter_by_status(params[:status], current_user.id)) if params[:status].present?
    @pagy, @tasks = pagy(Task.filter_by_user_id(params[:user_id])) if params[:user_id].present? && current_user.admin?
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
    params.require(:task).permit(:title, :description, :status)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def authorize_task
    authorize(@task || Task)
  end

  def sort_reverse
    if session[:sort_rev] == true
      session[:sort_rev] = false
      @pagy, @tasks = pagy(current_user.tasks.order(status: :asc))
    else
      session[:sort_rev] = true
      @pagy, @tasks = pagy(current_user.tasks.order(status: :desc))
    end
  end
end
