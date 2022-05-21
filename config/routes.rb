Rails.application.routes.draw do
  devise_for :users, :skip => [:password]
  resources :users, only: [:index, :edit, :update]
  root "tasks#index"
  resources :tasks
end
