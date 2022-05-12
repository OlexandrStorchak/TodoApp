module ApplicationHelper
  def loged_user
    current_admin || current_user
  end
end
