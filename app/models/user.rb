class User < ActiveRecord::Base
	has_many :articles , dependent: :destroy
	has_many :comments , through: :articles , dependent: :destroy
	has_many :likes , through: :articles , dependent: :destroy
  validates :email, email_format: { message: "doesn't look like an email address" }
  # attr_accessible :name , :email, :password, :password_confirmation ,:dob ,:role
  validates :password, :format => {:with => /([a-zA-Z]).([0-9])/,length: { minimum: 6 }, message: "must be minimum 6 characters & alphanumeric."}
  #validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  #
  # add any other characters you'd like to disallow inside the [ brackets ]
  # metacharacters [, \, ^, $, ., |, ?, *, +, (, and ) need to be escaped with a \


  # validates_confirmation_of :password

  has_secure_password


  

    #validates_format_of :password, :with => /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,}$/
     
     end
