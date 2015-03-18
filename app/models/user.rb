class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable 

  has_many :articles , dependent: :destroy
	has_many :comments , through: :articles, dependent: :destroy
	has_many :likes , through: :articles , dependent: :destroy
	validates_uniqueness_of :email
  validates :name, :presence => true
  validates_format_of :name,:with =>/\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates :email, email_format: { message: "doesn't look like an email address" }
  validates :password, :format => {:with =>  /(?=.*?[A-Za-z])(?=.*?[0-9])/, message: "must be alphanumeric."}
  validates :dob, :presence => true ,if: :allowed?

  def allowed?
     if dob.nil?
     else
       today = DateTime.now
          dif = (today - dob)/365
       unless(dif > 18)
        errors.add(:dob, "User should be 18 above in age")
        return false       
       end
     end
   end

   def self.get_user id 
     find(id)
   end

   def self.user id
     where('id != ?',id)
  end





end
