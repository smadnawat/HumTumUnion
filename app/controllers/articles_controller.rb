class ArticlesController < ApplicationController
	
	def new
      if(session[:id]!= nil)
        @user = User.where(:id => session[:id])
    else
     flash[:warning] = "sorry ! session expire"
     redirect_to new_user_path
    end 
	end
   
    def create
    if(session[:id]!= nil)
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


     else
        flash[:warning] = "sorry ! session expire"
          redirect_to new_user_path
     end
    end

    def show
    
     if(session[:id]!= nil)
       @user=User.find(params[:user_id])
       @article = Article.find(params[:id])
      else
        flash[:warning] = "sorry ! session expire"
        redirect_to new_user_path
     end
    end

    def edit 

     if(session[:id]!= nil)
      @user=User.find(params[:user_id])
      @article= Article.find(params[:id])
      #render :json => @article.id
     else
        flash[:warning] = "sorry ! session expire" 
        redirect_to new_user_path
     end
    end
   
  def update
      #@user=User.find(params[:id])
      #p "************#{@user.id}******#{@user.name}*****"
      
    if(session[:id]!= nil)

      @user=User.find(params[:user_id])
      @article = Article.find(params[:id])
       #render :json => @article.id
      if @article.update(params.require(:article).permit(:title, :text , :image))
          redirect_to  user_articles_path(@user,@article)
      else
          render 'edit'
      end
    else
        flash[:warning] = "sorry ! session expire" 
        redirect_to new_user_path
    end
  end


  def index
   if(session[:id]!= nil)
    @user=User.find(params[:user_id])    
    @article = Article.where(:user_id => @user.id)
   else
        flash[:warning] = "sorry ! session expire" 
        redirect_to new_user_path
   end
  end


  def destroy

   if(session[:id]!= nil)
    @article = Article.find(params[:id])
    @article.destroy 
    redirect_to user_articles_path
   else
        flash[:warning] = "sorry ! session expire" 
        redirect_to new_user_path
   end
   
  end


end

