Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root "pages#index"

  #Custom auth
  get "auth", to: "authentications#index"
  post "auth", to: "authentications#do_auth"
end
