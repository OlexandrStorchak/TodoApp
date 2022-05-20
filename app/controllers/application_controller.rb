class ApplicationController < ActionController::Base
  include Authorization
  include Pagy::Backend
end
