module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @user ||= User.new
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


 def find_user(uid)  
    User.find_by_id(uid.to_i)
 end

  def find_user_by_friend_id id
      User.find(id)
  end

  def current_user_request
  	Friendship.where("friend_id =? and accept = ? and block = ?",current_user.id,"false","false")
  end

  def current_user_date_request
    Dating.where("date_id = ? AND accept = ?",current_user.id,false)
  end

  def current_user_new_message
    Message.where("(reciever = ? and unread = ?) or ( user_id != ? and unread = ? and group_id != ?)",current_user.id,"unread",current_user.id,"unread",0)
  end

  def article_total_likes article
   Like.where(:article_id => article)
  end

  def user_like user,article
  	Like.where(:user_id => user , :article_id => article)  	
  end

  def article_comments article
  	Comment.where(:article_id => article)  	
  end

  def current_user_friends
      Friendship.where("(user_id = ? or friend_id =?) and accept = ? and block = ?",current_user.id,current_user.id,"true","false")
  end

  def find_friend_name friend
    if current_user.id != friend.friend_id
        find_user_by_friend_id(friend.friend_id).name      
    else        
          friend.user.name
    end
  end

  def find_friend friend
    if current_user.id != friend.friend_id
      # @id = friend.friend_id
      # @name= find_user_by_friend_id(friend.friend_id).name
      # ValueHolder.new(@id, @name)
      { :id => friend.friend_id, :name => find_user_by_friend_id(friend.friend_id).name }
             
    else    
      # @id = friend.user_id
      # @name= friend.user.name
      # ValueHolder.new(@id, @name)    
     { :id => friend.user_id, :name => friend.user.name }
    end
  end

  def is_like article, current_user
    Like.where(:user_id => current_user.id , :article_id => article.id).first ? true : false
  end

  def is_user_in_group(user,group)
    @member = User.find_by_id(user)
    group.users.include?(@member)
  end
  def date_request date
    @user = User.find(date)
    @user.name
  end
  def dating_condition date
    Dating.where("datable_id = ? AND date_id = ? AND accept = ?", date, current_user.id, false).first
  end
end
