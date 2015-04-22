class SessionsController < ApplicationController
  
  before_action :require_login 

  def index    
    @user=User.get_user(params[:id])
    @today = Date.today
    @lastday= @today + 6.days
    @article = Article.where("user_id = ?",current_user.id)
  end

  def usertitle
    @user=User.get_user(params[:user_id])
    @article = Article.get_article(params[:id])
    @likes = Like.article_total_likes(@article.id)
    @Current_like = Like.user_like(current_user.id,@article.id)
    @Current_total_like =@Current_like.count
    @comments = Comment.article_comments(@article.id)
  end

  def show
     @request = Friendship.where("friend_id=? and accept = ? and block = ? ",current_user.id,"false","false")   
  end
 
  def friendlist
   @user = User.find(params[:id])
   @request = Friendship.where("(user_id = ? or friend_id =?) and accept = ? and block = ?",@user.id,@user.id,"true","false")
  
  end

  def find_friend
    @user = User.find(params[:id])
    @find_friends = User.all_friends(@user.id,"notfrields")
  end


  def search_people
    @users = User.where('name LIKE ?', "%#{params[:search_users][:users]}%")
  end



  def send_request
    @user = User.find(params[:id])
    @send = @user.friendships.create(:friend_id => params[:friend_id],:block=>"false",:accept=>"false")
    if @send
      redirect_to find_friend_path(@user), :notice => "request sent"
    else
      redirect_to find_friend_path(@user), :notice => "request can not send"
    end
  end

  def accept_request
    @user = User.find(params[:id])
    @request = Friendship.find(params[:request_id])
    @request.accept = "true"
    if @request.save
      redirect_to show_request_path(@user), :notice => "Now you are friend with #{@request.user.name}"
    else
       redirect_to show_request_path(@user), :notice => "something wrong"
    end
  end

  def sent_request
    @sent_request = Friendship.where("user_id = ? and accept = ? ",current_user.id,"false")
  end

  def count_request
    @user = User.find(params[:id])
    request = Friendship.where("friend_id=? and accept = ? and block = ? ",@user.id,"false","false")
    date_request =  Dating.where("date_id = ? AND accept = ?",current_user.id,false)
    new_message =  Message.where("(reciever = ? and unread = ?) or ( user_id != ? and unread = ? and group_id != ?)",current_user.id,"unread",current_user.id,"unread",0)


    respond_to do |format|
     format.js{ render "count_request", :locals => {:request => request , :date_request => date_request, :new_message => new_message} }
    end
  end

  def reject_request
    @user = User.find(params[:id])
    @request =Friendship.find(params[:request_id])
    if @request.destroy
      redirect_to session_path(@user), :notice => "you have rejected the request from #{@request.user.name}"
    else
      redirect_to session_path(@user), :notice => "something wrong"
    end
  end

  def unfriend
    @user = User.find(params[:id])
    @request =Friendship.find(params[:request_id])
    if @request.destroy
      redirect_to friend_list_path(@user), :notice => " Now you are not friend with #{@request.user.name}"
    else
      redirect_to friend_list_path(@user), :notice => "something wrong"
    end
  end

  def block
    @user = User.find(params[:id])
    @request = Friendship.find(params[:request_id])
    @request.block = "true"
    @request.blocked_by = @user.id
    if @request.save
      redirect_to friend_list_path(@user), :notice => "you have blocked  #{@request.user.name}"
    else
      redirect_to friend_list_path(@user), :notice => "something wrong"
    end
  end

  def unblock
    @user = User.find(params[:id])
    @request = Friendship.find(params[:request_id])
    @request.block = "false"
    @request.blocked_by = ""
    if @request.save
      redirect_to block_list_path(@user), :notice => "you have unblocked  #{@request.user.name}"
    else
      redirect_to block_list_path(@user), :notice => "something wrong"
    end

  end

  def block_list
    @user = User.find(params[:id])
    @blocked_request = Friendship.where("blocked_by = ?",@user.id)
  end




 
end
