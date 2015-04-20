class ProfilesController < ApplicationController
  before_action :require_login 
	 def new

	 end

	 def show
	 	@user = User.find(params[:id])
	 	@profile = @user.profile
	 end

	def edit
		@user = User.find(params[:user_id])
	 	@profile = @user.profile
	end

	def update
		@user=User.get_user(params[:user_id])
	    @profile = @user.profile
	    if @profile.update(params_require)
	      redirect_to   profile_path(@user)
	    else
	      render 'edit'
	    end
	end

	

 def params_require
   params.require(:profile).permit!
  end

end
