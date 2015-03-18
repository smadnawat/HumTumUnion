# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Signup::Application.initialize!


ActionMailer::Base.smtp_settings = {
  :user_name => 'jairajput.kiet@gmail.com',
  :password => 'Mobiloitte1',
  :domain => 'gmail.com',
  :address => 'smtp.gmail.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}