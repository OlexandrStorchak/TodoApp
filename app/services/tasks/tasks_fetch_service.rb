module Tasks
  class TasksFetchService
    def initialize(user, params)
      @params = params
      @user = user
      @result = {}
    end

    def call
      return sort_tasks_by_status if @params[:sort_status].present?
      return filter_tasks_by_status if @params[:status].present?
      return tasks_by_user if @params[:user_id].present?
      return all_users_tasks if @params[:all_users_tasks].present?

      all_tasks
    end

    protected

    def all_tasks
      @result = { tasks: @user.tasks.all }
    end

    def sort_tasks_by_status
      @result = { tasks: @user.tasks.order(status: @params[:sort_status]), msg: 'Sort by status' }
    end

    def filter_tasks_by_status
      @result = { tasks: @user.tasks.filter_by_status(@params[:status], @user.id),
                  msg: "Filtered by \"#{@params[:status].capitalize}\" status" }
    end

    def tasks_by_user
      user = User.find_by(id: @params[:user_id])
      @result = { tasks: user.tasks.all, msg: "Tasks by user : #{user.email}" }
    end

    def all_users_tasks
      @result = { tasks: Task.all, msg: 'All users tasks' }
    end
  end
end
