Rails.application.routes.draw do
  devise_for :users, :skip => [:password]

  root "pages#index"
  resources :tasks
end
