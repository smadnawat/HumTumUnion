class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable 

  # has_secure_password

  after_save :build_profile
  
  has_many :friendships, dependent: :destroy
  has_many :articles , dependent: :destroy
	has_many :comments , through: :articles
	has_many :likes , through: :articles
  has_one  :profile, dependent: :destroy
  has_and_belongs_to_many :groups ,:join_table => "users_groups"
  has_many :messages , dependent: :destroy
  has_many :comments,:class_name => 'Comment',:foreign_key => 'Commenter'
   has_many :dates,:class_name => 'Dating',:foreign_key => 'datable'
	validates_uniqueness_of :email
  validates :name, :presence => true
  validates_presence_of :gender
  validates_format_of :name,:with =>/\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates :email, email_format: { message: "doesn't look like an email address" }
  validates :password, :format => {:with =>  /(?=.*?[A-Za-z])(?=.*?[0-9])/, message: "must be alphanumeric."}
  validates :dob, :presence => true ,if: :allowed?




  def build_profile
     @myprofile =  Profile.create(:user_id => self.id,:contact => "Not available" ,:image => nil ,:status=>"Not available",:about => "Not available",:address => "Not available",:city => "Not available",:country => "Not available",:hobby => "Not available",:state => "Not available",:zipcode => 000000)
  end

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
  def self.authenticate_user email,password
        @user = where("email=?",email).first
        
        if @user and @user.valid_password?(password) 
         @user
        else
         false
        end 
    end
  def updatepassword newpassword,confirmpassword
   self.update_attributes(:password => newpassword, :password_confirmation => confirmpassword)
  end
 
end
