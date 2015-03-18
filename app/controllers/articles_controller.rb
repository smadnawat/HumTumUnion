class ArticlesController < ApplicationController
	
  before_action :require_login 
 
	def new    
    #@user = User.where(:id => current_user.id)
  end

	def create
   @user=User.get_user(params[:user_id])
   @title = params[:article][:title]
   @text =params[:article][:text]
   @date = params[:article][:date]
    if @title != '' && @text != '' && @date != ''
      @article=@user.articles.create(:title => @title.strip , :text => @text.strip ,:date => @date , :image => params[:article][:image])
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
    @user=User.get_user(params[:user_id])    
    @article = Article.user_articles(current_user.id)
  end


  def destroy
   @article = Article.get_article(params[:id])
   @article.destroy 
   redirect_to user_articles_path
  end

  def params_require
   params.require(:article).permit(:title, :text , :date ,:image)
  end


end

