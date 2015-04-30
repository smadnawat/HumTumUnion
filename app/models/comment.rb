class Comment < ActiveRecord::Base
  belongs_to :user,:class_name => 'User',:foreign_key => 'Commenter'
  belongs_to :article
  has_many :notifications, as: :notificable ,dependent: :destroy
  validates_presence_of :comment
  

 after_save :create_notification


def create_notification
    @post = self.article
    @receiver = @post.user
    @message = "#{self.user.name} commented on your post "
    self.notifications.create(:pending => true,:user_id => self.user.id,:receiver => @receiver.id,:article_id => @post.id,:message=> @message)
 end

  # def self.article_comments article
  # 	where(:article_id => article)  	
  # end
end
