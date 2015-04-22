class UsersController < ApplicationController
 before_action :require_login  , only:  [:setting ,:update_password]
  def new
  	if current_user.present?
      @request = Friendship.where("friend_id=? and accept = ? and block = ? ",current_user.id,"false","false")
      @friends = User.all_friends(current_user.id,"friends").pluck(:id) 	
     # @friends << current_user.id
      @article = Article.order('created_at desc') 
      #@article = Article.where("user_id IN (?)",@friends ).order('created_at desc') 
      @people_you_may_know = User.all_friends(current_user.id,"friends")
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
