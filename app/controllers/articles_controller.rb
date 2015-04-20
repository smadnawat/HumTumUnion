class ArticlesController < ApplicationController
	
  before_action :require_login 
 
	def new    
    #@user = User.where(:id => current_user.id)
  end

	def create
     @about =params[:article][:about]
     @image = params[:article][:image]
    if @about != '' or @image != nil
      @article=current_user.articles.create(:title =>"Blank" , :about => @about.strip ,:date => Date.today , :image => params[:article][:image])
       #render :json => @article
      if @article.id != nil
       redirect_to root_path(current_user)
      else
       flash[:warning] = "Something wrong"
       redirect_to root_path(current_user)
      end
    else
      flash[:warning] = " provide required data"
      redirect_to root_path(current_user)
    end
  end


  def show
    @user=User.get_user(params[:user_id]) # get_user method is called from User model class, this is a class method this is called by class name
    @article = Article.get_article(params[:id])  # get_article method is called from Article model class, this is a class method this is called by class name
  end

  def edit 
    @user=User.get_user(params[:user_id])
    @article= Article.get_article(params[:id])
  end
   
  def update
    @user=User.get_user(params[:user_id])
    @article = Article.get_article(params[:id])
    if @article.update(params_require)
      redirect_to  user_articles_path(@user,@article)
    else
     render 'edit'
    end
  end

  def index
    @user=User.get_user(current_user.id)    
    @article = Article.user_articles(current_user.id)
  end


  def destroy
   @article = Article.get_article(params[:id])
   @article.comments.each{|c| c.destroy}
   @article.likes.each{|l| l.destroy}
   @article.destroy
    redirect_to user_articles_path
  
  end

  def params_require
   params.require(:article).permit(:title, :about , :date ,:image)
  end


end

