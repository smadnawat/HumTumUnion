class SessionsController < ApplicationController
  
  before_action :require_login 

  def index    
    @user=User.get_user(params[:id])
    @today = Date.today
    @lastday= @today + 6.days
    @article = Article.where("user_id = ?",current_user.id)
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
    @user_ids = User.where("id != ?",@user.id).pluck(:id)
    @request = Friendship.where("user_id = ? or friend_id = ?",@user.id,@user.id) 
    @friend_users = Array.new
    temp = 0
    @request.each do |request|
      if request.user_id == @user.id
        @friend_users[temp] = request.friend_id
      else
        @friend_users[temp] = request.user_id
      end
      temp += 1
    end
    @are_not_friends_ids = @user_ids.reject{ |e| @friend_users.include? e }
    @find_friends = User.where("id IN (?)",@are_not_friends_ids)
  end

  def search_people
    @users = User.where('name LIKE ?', "%#{params[:search_users][:users]}%")
  end

  def send_request
    @user = User.find(params[:id])
    @friend = User.find(params[:friend_id])
    @requests = current_user.friendships.pluck(:friend_id)
    if  @requests.include?(@friend.id)
        redirect_to find_friend_path(@user), :notice => "request already sent"
    else
        @send = @user.friendships.create(:friend_id => params[:friend_id],:block=>"false",:accept=>"false")
        if @send
         redirect_to find_friend_path(@user), :notice => "request sent"
        else
         redirect_to find_friend_path(@user), :notice => "request can not send"
        end
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
     current_user_groups = current_user.groups   
    new_message =  Message.where("(reciever = ? and unread = ?) or ( user_id != ? and unread = ? and group_id IN (?))",current_user.id,"unread",current_user.id,"unread",current_user_groups)
    new_notification = Notification.where("receiver = ? and user_id != ? and pending =  ?",current_user.id,current_user.id,true)

    respond_to do |format|
     format.js{ render "count_request", :locals => {:request => request , :date_request => date_request, :new_message => new_message,:new_notification => new_notification} }
    end
  end

  def reject_request
    @user = User.find(params[:id])
    @request =Friendship.find(params[:request_id])
    if @request.destroy
      redirect_to sent_request_path, :notice => "you have rejected the request"
    else
      redirect_to sent_request_path, :notice => "something wrong"
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
