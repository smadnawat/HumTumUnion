class Comment < ActiveRecord::Base
  belongs_to :article
  validates_presence_of :comment


  def self.article_comments article
  	where(:article_id => article)  	
  end
end
