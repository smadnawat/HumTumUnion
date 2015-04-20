class Profile < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :user_id

  mount_uploader :image, ImageUploader
  	
end
