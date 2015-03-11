class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # I have to decleare this method here this can be use any where in the application
  helper_method :current_user

  def current_user
  	User.find_by_id(session[:id].to_i) if session[:id].present?
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
