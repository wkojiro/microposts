class StaticPagesController < ApplicationController
  def home
    if logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
    @user = current_user
    @microposts = @user.microposts
    @favorite = @user.favorites
    #@retweet_count = Micropost.group(:origin_id).having(id:@micropost.id).count
     #@retweet_count = Micropost.where(origin_id: micropost.user.id).count
    end
  end
end
 