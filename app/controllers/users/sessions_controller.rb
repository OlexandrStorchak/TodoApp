# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :get_user, only: [:create]
  #GET /resource/sign_in
  #def new
  # super
  #end

  # POST /resource/sign_in
  #def create
  #  super
  #end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  def get_user
    redirect_to new_admin_session_path if !Admin.find_by(email: params[:user][:email]).nil?
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
