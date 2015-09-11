class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update,:destroy]

 def show 
    if User.exists?(params[:id])
     @user = User.find(params[:id])
     @microposts = @user.microposts
    else
    render 'error/usernotexist.html'
    end
 end
 
 def followings
     @user = User.find(params[:id])
     @followings = @user.following_users
 end

 def followers
     @user = User.find(params[:id])
     @followers = @user.follower_users
 end
 
 def new
    @user = User.new
 end
 
 def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = "Welcome to the Sample App!"    
       redirect_to @user
    else
       render 'new'
    end
 end
 
 def edit
   @user = User.find(params[:id])
 end

 def update
    if @user.update(user_params)
       flash[:success] = "update done!"    
       redirect_to @user
    else
       render 'edit'
    end
 end
 
 def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
 end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :area, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end

