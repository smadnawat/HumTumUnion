# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Signup::Application.initialize!


ActionMailer::Base.smtp_settings = {
  :user_name => 'humtumunion@gmail.com',
  :password => 'humtumunion@htu',
  :domain => 'gmail.com',
  :address => 'smtp.gmail.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}