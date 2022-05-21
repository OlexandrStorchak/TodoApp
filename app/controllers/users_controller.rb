class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]
  before_action :authorize_user

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile successfully updated"
      redirect_to edit_user_path @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def authorize_user
    authorize(@user || User)
  end

  def user_params
    if current_user.admin?
      params.require(:user).permit(:email, :first_name, :last_name, :role)
    else
      params.require(:user).permit(:first_name, :last_name)
    end
  end
end
