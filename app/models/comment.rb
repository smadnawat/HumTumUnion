class Comment < ActiveRecord::Base
  belongs_to :article
  validates_presence_of :comment
  belongs_to :user,:class_name => 'User',:foreign_key => 'Commenter'


  # def self.article_comments article
  # 	where(:article_id => article)  	
  # end
end
