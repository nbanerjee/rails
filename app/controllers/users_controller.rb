class UsersController < ApplicationController
  before_action :signedin_user, only: [:index, :edit, :update, :destroy]
  before_action :currect_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if(@user.update_attributes(users_param))
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @feed_items = @user.feed.paginate(page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def users_param
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def currect_user
    @user = User.find(params[:id])
    redirect_to root_url, notice: "Not currect user" unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url, notice: "You are not admin" unless current_user.admin?
  end
end
