module ApplicationHelper
  include Pagy::Frontend

  def loged_user
    current_admin || current_user
  end

  def form_errors_helper(obj, column)
    render partial: "layouts/errors", locals: { obj: obj, column: column } if obj.errors.where(column).any?
  end

  def sort_reverse_button
    if params[:sort_status] == "desc"
      link_to " Sort by status", tasks_path + "?sort_status=asc", class: "btn btn-sm btn-outline-info ms-1 bi bi-arrow-down-up"
    else
      link_to " Sort by status", tasks_path + "?sort_status=desc", class: "btn btn-sm btn-outline-info ms-1 bi bi-arrow-down-up"
    end
  end
end
