class AdminController < ApplicationController
  before_action :require_login 

  def new
   @user = User.new
  end

  def index
   @user = User.get_user(params[:id])
   @users = User.user(current_user)
  end

  def index_post
    @user=User.get_user(current_user.id)    
    @article = Article.user_articles(current_user.id)
  end

  def all_groups
    @user = User.get_user(params[:id])
    @group= Group.all
  end

  def destroy
   @user = User.get_user(params[:user_id])
   @deleteuser = User.get_user(params[:id])
   # @deleteuser.comments.each{ |c| c.destroy }
   # @deleteuser.notifications.each{ |n| n.destroy }
   # @deleteuser.likes.each{ |l| l.destroy }
   # @deleteuser.articles.each{ |a| a.destroy }
   # @deleteuser.groups.each{|g| g.destroy }
   # @deleteuser.messages.each { |m| m.destroy }
      @request = Friendship.where("user_id = ? or friend_id = ?",@deleteuser.id,@deleteuser.id) 
      @friends = User.all_friends(@deleteuser.id,"allrequests")
      @friends.each do |f|
        @friends_messages= f.messages.where("reciever = ? ",@deleteuser.id)
        @friends_messages.destroy_all
      end
      @deleteuser.groups.destroy_all
      @request.destroy_all
      @deleteuser.destroy
   
   #@article.comments.each{|c| c.destroy}
   #@article.likes.each{|l| l.destroy}
   #@article.destroy

   redirect_to adminindex_path(@user)
  end

end
