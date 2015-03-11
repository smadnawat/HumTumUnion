class CommentsController < ApplicationController
  before_action :require_login
  def new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to usertitle_path(@article.user_id,@article)
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to usertitle_path(@article.user_id,@article)
  end

   private
   def comment_params
      params.require(:comment).permit(:Commenter , :comment)
   end
  end
