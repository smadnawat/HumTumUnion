class Like < ActiveRecord::Base
  belongs_to :article

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
