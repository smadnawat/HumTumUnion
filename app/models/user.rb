class User < ActiveRecord::Base
	has_many :articles , dependent: :destroy
	has_many :comments , through: :articles , dependent: :destroy
	has_many :likes , through: :articles , dependent: :destroy
  validates :email, email_format: { message: "doesn't look like an email address" }
  # attr_accessible :name , :email, :password, :password_confirmation ,:dob ,:role
  validates :password, :format => {:with =>  /(?=.*?[A-Za-z])(?=.*?[0-9])/,length: { minimum: 6 }, message: "must be minimum 6 characters & alphanumeric."}
  #validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates :name, :presence => true
  validates_format_of :name,:with =>/\A[^0-9`!@#\$%\^&*+_=]+\z/
  #with: /\A[a-zA-Z]+\z/   # without any white space and alphabates only
  #:with => /\A[^0-9`!@#\$%\^&*+_=]+\z/  # allow white space but does not allow numeric and special character
  

  # validates :dob, :presence => true
  # validate  :dob_is_over18

  # def birthday_is_date
  #   errors.add(:dob, "should be over 18 years") if ( dob > time.now-18 rescue ArgumentError) == ArgumentError)
  # end
  # add any other characters you'd like to disallow inside the [ brackets ]
  # metacharacters [, \, ^, $, ., |, ?, *, +, (, and ) need to be escaped with a \
 
  # validates_confirmation_of :password

  has_secure_password


  

    #validates_format_of :password, :with => /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,}$/
     
     end
