class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # I have to decleare this method here this can be use any where in the application
 before_action :configure_permitted_parameters, if: :devise_controller?

 def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :dob  << :gender
 end

  def require_login
  	unless logged_in?
  	 flash[:warning] = "You must be logged in to access this section"
     redirect_to new_user_path # Prevents the current action from running
    end
  end

  def logged_in?
	   current_user
  end
end
