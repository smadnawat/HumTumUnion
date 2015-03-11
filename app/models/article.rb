class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments , dependent: :destroy
  has_many :likes , dependent: :destroy
  
  validates_presence_of :title, :text
  validates_format_of :title, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  

  mount_uploader :image, ImageUploader
end
