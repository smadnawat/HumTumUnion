class AdminController < ApplicationController
  before_action :require_login 

  def new
   @user = User.new
  end

  def index
   @user = User.find(params[:id])
   @users = User.where('id != ?',@user.id)
  end

  def destroy
   @user = User.find(params[:user_id])
   @deleteuser = User.find(params[:id])
   @deleteuser.destroy 
   redirect_to adminindex_path(@user)
  end

end
