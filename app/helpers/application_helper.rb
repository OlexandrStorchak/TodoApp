module ApplicationHelper
  include Pagy::Frontend

  def loged_user
    current_admin || current_user
  end

  def form_errors_helper(obj, column)
    render partial: "layouts/errors", locals: { obj: obj, column: column } if obj.errors.where(column).any?
  end
end
