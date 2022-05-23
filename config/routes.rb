Rails.application.routes.draw do
  devise_for :users, :skip => [:password]
  resources :users, only: [:index, :edit, :update]
  root "tasks#index"
  resources :tasks
  get "/by_user/", to: "tasks#tasks_by_user", as: "tasks_by_user"
  get "/all_users_tasks/", to: "tasks#all_users_tasks", as: "all_users_tasks"
end
