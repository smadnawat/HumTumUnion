class UsersController < ApplicationController
 before_action :require_login  , only:  [:setting ,:update_password]

  def new
  	if current_user.present?
      @requests = Friendship.where("(user_id = ? or friend_id = ?) and accept = ? and block =?",current_user.id,current_user.id, "true","false") 
      @friend_users = Array.new
      temp = 0
      @requests.each do |request|
      if request.user_id == current_user.id
        @friend_users[temp] = request.friend_id
      else
        @friend_users[temp] = request.user_id
      end
      temp += 1
    end
    @friend_users[@friend_users.length] = current_user.id
     @article = Article.where("user_id IN (?)",@friend_users).order('created_at desc') 
    end
  end

	def setting
		@user = User.find(params[:id])
	end

  def update_password  
     @user = User.authenticate_user(current_user.email,params[:user][:password])
      if @user 
        if @user.updatepassword(params[:user][:new_password],params[:user][:password_confirmation])
        	 flash[:notice] = "Password updated"
      	 	 redirect_to root_path
        else
          flash[:notice] = "Password doesn't match"
      	  render 'setting'
        end
      else
      	flash[:notice] = "Invalid old password"
        render 'setting'
      end  
  end


end
