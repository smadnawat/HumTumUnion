class CommentsController < ApplicationController
  
  def new

  end


  def create
    #logger.info "=======================#{params}"
    #@user= User.find(params[:user_id])
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
