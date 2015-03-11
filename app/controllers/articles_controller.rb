class ArticlesController < ApplicationController
	
  before_action :require_login 
 
	def new    
    @user = User.where(:id => session[:id])
  end

	def create
   @user=User.find(params[:user_id])
   @article=@user.articles.create(params.require(:article).permit(:title,:text,:date, :image))
   @title = params[:article][:title]
   @text =params[:article][:text]
    if @title != '' && @text != ''
      #p "*************#{@user}******************"
      redirect_to user_article_path(@user, @article)
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
      #render :json => @article.id
  end
   
  def update
   #@user=User.find(params[:id])
   #p "************#{@user.id}******#{@user.name}*****"
    @user=User.find(params[:user_id])
    @article = Article.find(params[:id])
    #render :json => @article.id
    if @article.update(params.require(:article).permit(:title, :text , :image))
      redirect_to  user_articles_path(@user,@article)
    else
     render 'edit'
    end
  end

  def index
    @user=User.find(params[:user_id])    
    @article = Article.where(:user_id => @user.id)
  end


  def destroy
   @article = Article.find(params[:id])
   @article.destroy 
   redirect_to user_articles_path
  end


end

