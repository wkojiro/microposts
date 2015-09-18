class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :favorite, :unfavorite]
    
    def create
      @micropost = current_user.microposts.build(micropost_params) #保存用　@micropost 単数形
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
            render 'static_pages/home'
        end
    end

    def destroy
     @micropost = current_user.microposts.find_by(id: params[:id])
     return redirect_to root_url if @micropost.nil?
     @micropost.destroy
     flash[:success] = "Micropost deleted"
     redirect_to request.referrer || root_url
    end
    
    def retweet
     @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "retweet created!"
            redirect_to request.referrer 
            #render 'static_pages/home'
        else
            render 'static_pages/home'
        end
    end
   
   def favorite
        @micropost = Micropost.find(params[:id])
        current_user.favorite(@micropost)  
        render 'microposts/favorite.js.erb'
   end
  
   def unfavorite
        @micropost = Micropost.find(params[:id])
        current_user.unfavorite(@micropost) 
        render 'microposts/unfavorite.js.erb'
   end
  
    private
    def micropost_params
        params.require(:micropost).permit(:content, :origin_id ,:image)
    end
    
end


