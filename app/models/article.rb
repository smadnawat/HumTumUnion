class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments , dependent: :destroy
  has_many :likes , dependent: :destroy
  
  validates_presence_of :title, :text

  mount_uploader :image, ImageUploader
end
