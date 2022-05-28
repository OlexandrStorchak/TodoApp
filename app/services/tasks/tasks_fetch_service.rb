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
      return tasks_by_user if @params[:user_id].present? && @user.admin?
      return all_users_tasks if @params[:all_users_tasks].present? && @user.admin?

      all_tasks
    end

    private

    def all_tasks(msg = nil)
      return @result = { tasks: @user.tasks.all } if msg.nil?

      @result = { tasks: @user.tasks.all, msg: msg }
    end

    def sort_tasks_by_status
      @result = { tasks: @user.tasks.order(status: @params[:sort_status]), msg: 'Sort by status' }
    end

    def filter_tasks_by_status
      @result = { tasks: @user.tasks.filter_by_status(@params[:status], @user.id),
                  msg: "Filtered by \"#{@params[:status].capitalize}\" status" }
    end

    def tasks_by_user
      if user = User.find_by(id: @params[:user_id])
        @result = { tasks: user.tasks.all, msg: "Tasks by user : #{user.email}" }
      else
        all_tasks('user not exist')
      end
    end

    def all_users_tasks
      @result = { tasks: Task.all, msg: 'All users tasks' }
    end
  end
end
