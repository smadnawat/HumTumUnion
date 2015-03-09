class SessionsController < ApplicationController
  
  def new
   @user = User.new
  end
  
  def create
     #@role = params[:session][:role]
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
    if(session[:id]!= nil)
    @user = User.find(params[:id])
    else
     flash[:warning] = "sorry ! session expire"
     redirect_to new_user_path
    end
  end


  def index    
    if(session[:id]!= nil)
     # @id= session[:id]
    @user=User.find(params[:id])
    @today = Date.today
    @lastday= @today + 6.days
    @article = Article.all.order('date ASC')
    else
     flash[:warning] = "Sorry ! Login required"
     redirect_to new_user_path
    end
  end

  def usertitle
     if(session[:id]!= nil)

       @user=User.find(params[:user_id])
       @article = Article.find(params[:id])
       @likes = Like.where(:article_id => @article.id)
       @comments = Comment.where(:article_id => @article.id)
      else
        flash[:warning] = "sorry ! session expire"
        redirect_to new_user_path
     end
  end



   # private

   #  def user_params
     
   #  end
  

end
