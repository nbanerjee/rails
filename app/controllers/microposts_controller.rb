class MicropostsController < ApplicationController
  before_action :signedin_user, only:[:create, :destroy]

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
end

private

def micropost_param
  params.require(:micropost).permit(:content)
end


end
