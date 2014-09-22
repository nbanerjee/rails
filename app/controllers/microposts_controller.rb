class MicropostsController < ApplicationController
  before_action :signedin_user, only:[:create, :destroy]
  before_action :correct_user, only:[:destroy]

def create
  @micropost = current_user.microposts.build(micropost_param)
  if @micropost.save
    flash[:success] = "micropost created"
    redirect_to root_url
  else
    @feed_itms = []
    render 'static_pages/home'
  end

end

def index
end

def destroy
  @micropost.destroy
  redirect_to root_url
end

private

def micropost_param
  params.require(:micropost).permit(:content)
end

def correct_user
  @micropost = current_user.microposts.find_by(id: params[:id])
  redirect_to root_url if @micropost.nil?
end

end
