class CommentsController < ApplicationController
  before_action :require_login
  
  def new
  end
  
  def add_comment
    @article = Article.get_article(params[:article])
    @comment = @article.comments.create(comment_params)
    @comments = @article.comments
     respond_to do |format|
        format.js{ render "add_comment", :locals => {:article => @article , :comments => @comments} }
     end
  end

  def destroy
    @article = Article.get_article(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    @comments = @article.comments
     respond_to do |format|
        format.js{ render "add_comment", :locals => {:article => @article , :comments => @comments} }
     end
  end

   private
   def comment_params
      params.require(:comment).permit(:Commenter , :comment)
   end
  end
