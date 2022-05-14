class ApplicationController < ActionController::Base
  devise_group :person, contains: [:user, :admin]
end
