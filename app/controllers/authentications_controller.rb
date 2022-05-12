class AuthenticationsController < ApplicationController
  def index
  end

  def do_auth
    if !Admin.find_by(email: params[:email]).nil?
      redirect_to new_admin_session_path
    elsif !User.find_by(email: params[:email]).nil?
      redirect_to new_user_session_path
    else
      redirect_to new_user_registration_path
    end
  end
end
