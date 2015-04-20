class Dating < ActiveRecord::Base
	 belongs_to :user,:class_name => 'User',:foreign_key => 'datable'
end
