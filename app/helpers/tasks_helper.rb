module TasksHelper
  def time_until_edit(task)
    time = task.created_at + 2.hours
    local_time(time, :time)
  end

  def index_page_tasks_list_empty(tasks)
    link_to "Create new task", new_task_path, class: "btn btn btn-outline-primary mt-50" if tasks.empty?
  end
end
