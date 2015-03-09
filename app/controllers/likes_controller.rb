class LikesController < ApplicationController

  def new

  end


  def create
    #logger.info "=======================#{params}"
    #@user= User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @user_id= params[:like][:user_id]
    #p "*****************#{@user_id}******************"
    @users = Like.where(:user_id => @user_id , :article_id => @article.id)
    #p "****************Like*#{@users.count}******************"
    @total =@users.count

    if @total==0
      
     @likes = @article.likes.create(comment_params)
    
     redirect_to usertitle_path(@article.user_id,@article)
     else     
      Like.where(:user_id => @user_id , :article_id => @article.id).destroy_all      
      redirect_to usertitle_path(@article.user_id,@article)   
     end
  end

  
  def index
     @article = Article.find(params[:article_id])
     @likes = Like.where(:article_id => @article.id)
  end



 
private
    def comment_params
      params.require(:like).permit(:user_id)
    end

	
end
