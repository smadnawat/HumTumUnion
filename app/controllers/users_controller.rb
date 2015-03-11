class UsersController < ApplicationController
  def new
  	@user=User.new
  end

  def create
   @user = User.new(user_params)
   age = params[:user][:dob]
   if age != ''  
     @check_age = (age.to_date + 18.years) < Date.today
     if @check_age
       if @user.save       
         session[:id] = @user.id  
         redirect_to show_path(@user)
       else
         render "new"
       end
     else
       @user.errors.add(:dob, "should be over 18 years old")
       render "new"
     end 
   else  
     @user.errors.add(:dob,"can not blank")
     render "new"
   end
  end

  def show
    @user = User.find(params[:id])
  end
 private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation ,:dob,:role)
  end
  
end
