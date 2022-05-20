Rails.application.routes.draw do
  devise_for :users, :skip => [:password]

  root "tasks#index"
  resources :tasks
end
