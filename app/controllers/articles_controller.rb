class ArticlesController < ApplicationController
	
  before_action :require_login 
 
	def new    
    #@user = User.where(:id => current_user.id)
  end

	def create
   @user=User.find(params[:user_id])
   @title = params[:article][:title]
   @text =params[:article][:text]
   @date = params[:article][:date]
    if @title != '' && @text != '' && @date != ''
      @article=@user.articles.create(params_require)
       #render :json => @article
      if @article.id != nil
       redirect_to user_article_path(@user, @article)
      else
       flash[:warning] = "provide valid Title"
       redirect_to new_user_article_path(@user)
      end
    else
      flash[:warning] = " provide required data"
      redirect_to new_user_article_path(@user)
    end
  end


  def show
    @user=User.find(params[:user_id])
    @article = Article.find(params[:id])
  end

  def edit 
    @user=User.find(params[:user_id])
    @article= Article.find(params[:id])
  end
   
  def update
    @user=User.find(params[:user_id])
    @article = Article.find(params[:id])
    if @article.update(params_require)
      redirect_to  user_articles_path(@user,@article)
    else
     render 'edit'
    end
  end

  def index
    @user=User.find(params[:user_id])    
    @article = Article.where(:user_id => current_user.id)
  end


  def destroy
   @article = Article.find(params[:id])
   @article.destroy 
   redirect_to user_articles_path
  end

  def params_require
   params.require(:article).permit(:title, :text , :date ,:image)
  end


end

