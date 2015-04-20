class AdminController < ApplicationController
  before_action :require_login 

  def new
   @user = User.new
  end

  def index
   @user = User.get_user(params[:id])
   @users = User.user(current_user)
  end

  def all_groups
    @user = User.get_user(params[:id])
    @group= Group.all
  end

  def destroy
   @user = User.get_user(params[:user_id])
   @deleteuser = User.get_user(params[:id])
   @deleteuser.comments.each{ |c| c.destroy }
   @deleteuser.likes.each{ |l| l.destroy }
   @deleteuser.articles.each{ |a| a.destroy }
   @deleteuser.groups.each{|g| g.destroy }
   @deleteuser.messages.each { |m| m.destroy }
   @deleteuser.destroy
   
   #@article.comments.each{|c| c.destroy}
   #@article.likes.each{|l| l.destroy}
   #@article.destroy

   redirect_to adminindex_path(@user)
  end

end
