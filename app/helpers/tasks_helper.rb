module TasksHelper
  def time_until_edit(task)
    time = task.created_at + 2.hours
    local_time(time, :time)
  end

  def index_page_tasks_list_empty(_tasks)
    link_to 'Create new task', new_task_path, class: 'btn btn btn-outline-primary' if current_user.tasks.empty?
  end

  def sort_reverse_button
    if params[:sort_status] == 'asc'
      link_to ' Sort by status', tasks_path + '?sort_status=desc',
              class: 'btn btn-sm btn-outline-info ms-1 bi bi-arrow-down-up'
    else
      link_to ' Sort by status', tasks_path + '?sort_status=asc',
              class: 'btn btn-sm btn-outline-info ms-1 bi bi-arrow-down-up'
    end
  end
end
