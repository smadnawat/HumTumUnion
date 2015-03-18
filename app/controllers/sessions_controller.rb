class SessionsController < ApplicationController
  
  before_action :require_login , only: [:show, :usertitle,:index ]


  def index    
    @user=User.get_user(params[:id])
    @today = Date.today
    @lastday= @today + 6.days
    @article = Article.all_articles
  end

  def usertitle
    @user=User.get_user(params[:user_id])
    @article = Article.get_article(params[:id])
    @likes = Like.article_total_likes(@article.id)
    @Current_like = Like.user_like(current_user.id,@article.id)
    @Current_total_like =@Current_like.count
    @comments = Comment.article_comments(@article.id)
  end
 
end
