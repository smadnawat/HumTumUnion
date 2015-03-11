class SessionsController < ApplicationController
  
  before_action :require_login , only: [:show, :usertitle,:index ]

  def new
   @user = User.new
  end
  
  def create
   @user = User.find_by_email(params[:session][:email])  
   if @user && @user.authenticate(params[:session][:password])
     session[:id] = @user.id  
     redirect_to show_path(@user)
   else
     flash[:warning]  = "Invalid email or password"
     redirect_to new_user_path
   end 
  end

  def destroy
   session[:id] = nil
   redirect_to root_url, :notice => "Logged out!"
  end

  def show
   @user = User.find(params[:id])
  end

  def index    
    @user=User.find(params[:id])
    @today = Date.today
    @lastday= @today + 6.days
    @article = Article.all.order('date ASC')
  end

  def usertitle
    @user=User.find(params[:user_id])
    @article = Article.find(params[:id])
    @likes = Like.where(:article_id => @article.id)
    @comments = Comment.where(:article_id => @article.id)
  end
 
end
