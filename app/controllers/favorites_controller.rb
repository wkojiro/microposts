class FavoritesController < ApplicationController
    before_action :logged_in_user
    def create
        @micropost = Micropost.find(params[:id])
        @favorite = current_user.favorite(@micropost)
    end
    
    def destroy
        @micropost = Micropost.find(params[:id])
        @favorite = current_user.favorite.find(params[:id]).unfavorite
    end
end