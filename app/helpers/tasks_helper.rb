module TasksHelper
  def time_until_edit(task)
    time = task.created_at + 2.hours
    local_time(time, :time)
  end
end
