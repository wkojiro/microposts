class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :favorite, :unfavorite]
    
    def create
      @micropost = current_user.microposts.build(micropost_params) #保存用　@micropost 単数形
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
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
            redirect_to request.referrer || root_url
        else
            render 'static_pages/home'
        end
    end
   
   def favorite
     @micropost = Micropost.find(params[:id])
    current_user.favorite(@micropost) 
   end
  
   def unfavorite
    @micropost = Micropost.find(params[:id])
    current_user.unfavorite(@micropost) 
   end
  
    private
    def micropost_params
        params.require(:micropost).permit(:content, :origin_id)
    end
    
end


