class UsersController < ApplicationController
  def new
  	@user=User.new
    session[:id]=nil
  end

  def create
   @user = User.new(user_params)
   age = params[:user][:dob]
          
    #p "***************#{age}******#{Date.today}***************"
      if age != ''  
        @check_age = (age.to_date + 18.years) < Date.today
        
         if @check_age
 
           if @user.save       
             redirect_to @user
           else
             render "new"
           end
         else
           @user.errors.add(:dob, "should be over 18 years old")
           render "new"
         end 
      else  
        @user.errors.add(:dob, "Date of birth can not blank")
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
