class Notification < ActiveRecord::Base

  belongs_to :notificable, polymorphic: true
  belongs_to :user
  belongs_to :article

end
