class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(users_param)
    if(@user.save)
      sign_in @user
      flash[:success] = "Welcome to the sample app!"
      redirect_to users_path
    else
      redirect_to new_user_path
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def users_param
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
