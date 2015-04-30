class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  has_many :notifications, as: :notificable, dependent: :destroy
  after_save :create_notification
  

  def create_notification
    @post = self.article
    @receiver = @post.user
    @message = "#{self.user.name} likes your post"
    self.notifications.create(:pending => true,:user_id => self.user.id,:receiver => @receiver.id,:article_id => @post.id,:message=> @message)
  end

  def self.article_total_likes article
   Like.where(:article_id => article)
  end

  def self.user_like user,article
  	Like.where(:user_id => user , :article_id => article)
  end

  def self.delete_user_like user,article
  	Like.where(:user_id => user , :article_id => article).destroy_all        	
  end
 
end
