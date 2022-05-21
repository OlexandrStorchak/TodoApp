class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :user_params, only: :update

  def index
    @users = User.all
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:notice] = "User successfully updated"
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def authorize_user
    authorize(@user || User)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name) if current_user.user?
    params.require(:user).permit(:first_name, :last_name, :role) if current_user.admin?
  end
end
