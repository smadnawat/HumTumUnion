class Article < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  #validates_format_of :title, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  

  mount_uploader :image, ImageUploader

 def self.get_article id
 	find_by_id(id)
 end

 def self.user_articles id
     where(:user_id => id)
 end

 def self.all_articles
    all.order('date ASC')
 end

 # def my_method
 #  self.find 	
 # end


end
