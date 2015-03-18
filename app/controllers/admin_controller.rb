class AdminController < ApplicationController
  before_action :require_login 

  def new
   @user = User.new
  end

  def index
   @user = User.get_user(params[:id])
   @users = User.user(current_user)
  end

  def destroy
   @user = User.get_user(params[:user_id])
   @deleteuser = User.get_user(params[:id])
   @deleteuser.destroy 
   redirect_to adminindex_path(@user)
  end

end
