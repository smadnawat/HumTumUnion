class LikesController < ApplicationController
 
  before_action :require_login 
  def new
  end

  def create
    @article = Article.get_article(params[:article_id])
    @user_id= params[:like][:user_id]
    @users = Like.user_like(@user_id,@article.id)
    @total =@users.count
    if @total==0
     @likes = @article.likes.create(comment_params)
     redirect_to usertitle_path(@article.user_id,@article)
    else     
     Like.delete_user_like(@user_id,@article.id)      
     redirect_to usertitle_path(@article.user_id,@article)   
    end
  end
  
  def index
    @article = Article.get_article(params[:article_id])
    @likes = Like.article_total_likes(@article.id)
  end 

  private
  def comment_params
   params.require(:like).permit(:user_id)
  end

end
