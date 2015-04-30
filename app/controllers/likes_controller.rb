class LikesController < ApplicationController
 
  before_action :require_login 
  def new
   
  end

  
  def index
    @article = Article.get_article(params[:article_id])
    @likes = Like.article_total_likes(@article.id)
  end 

  def feeds
    @user = User.find(params[:id])
    @article = Article.order('created_at desc') 
    respond_to do |format|
      format.js{ render "feeds", :locals => {:user => @user } }
    end
  end

  def like_it
      @article = Article.get_article(params[:article_id])

       @like = Like.user_like(current_user.id,@article.id)
        @total =@like.count
        #  p "*********************#{@total}*********"
          if @total==0
           @likes = @article.likes.create(:user_id => current_user.id)
           # @user = @likes.notifications.user.name
           # p "*************************#{@user}*****************************"
          else
            @current_like = @like.first
           @notification = @current_like.notifications
           @notification.each{ |n| n.destroy }
           Like.delete_user_like(current_user,@article.id) 
          end

          respond_to do |format|
            format.js{ render "like_it", :locals => {:articlee => @article} }
          end
  end

end
