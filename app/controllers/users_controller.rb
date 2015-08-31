class UsersController < ApplicationController
 def new
    @user = User.new
 end
 
 def create
    @user = User.new(user_params)
    if @user.save
    else
      render 'new'
    end
 end
  
  private
  # permit でホワイトリスト指定(ストロングパラメータ）name , email ,　password , password confirmation は許可している(それ以外は認めない）、という意味。
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

