class AdminController < ApplicationController
  
  def new
   @user = User.new
  end

  def create

  	# @name =params[:admin][:name]
   #  @email=params[:admin][:email]   
   #  @password1=params[:admin][:password]
  	# @password2=params[:admin][:password_confirmation]
   # if (@name!='' && @email!= '' && @password1!='')
  	#  if (@password1==@password2)
   #      @user = User.new(user_params)
   #      if @user.save       
   #         redirect_to  adminshow_path(@user)
   #      else
   #         #render 'new'
   #          flash[:warning] = "#{@email} already exist"
   #              redirect_to( :back )
   #      end
  	#  else
   #    flash[:warning] = "***Password does't match***"
  	# 	     redirect_to( :back )
  	#  end

   # else
   #    flash[:warning] = "***Provide required data***"
   #    redirect_to( :back )
   # end
    

  end

  def show

    # if(session[:user]!= nil)
    #    @user = User.find(params[:id])
    # else
    #  flash[:warning] = "sorry ! session expire"
    #  redirect_to new_user_path
    # end

  end

  def index
   #  @user = User.find(params[:id])
  	# @users = User.where('id != ?',@user.id)

  end

  def destroy
   # if(session[:user]!= nil)
   # 	@user = current_user.id
   #  @deleteuser = User.find(params[:id])
   #  @deleteuser.destroy 
   #  redirect_to adminindex_path(@user)
   # else
   #      flash[:warning] = "sorry ! session expire" 
   #      redirect_to new_user_path
   # end


  end

  # private

  #   def user_params
  #     params.require(:admin).permit(:name, :email, :password ,:role)
  #   end

end
