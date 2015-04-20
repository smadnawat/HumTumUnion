class DatingsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @today = Date.today
    @lastday= @today + 6.days
    @dating = Dating.where("(date_id = ? or datable_id = ?) AND accept = ?",current_user.id,current_user.id, true).order('time_of_dating asc')
  	@request = Friendship.where("(user_id = ? or friend_id =?) and accept = ? and block = ?",@user.id,@user.id,"true","false")
  end
  def create
    @date = params[:dateform][:datingtime]
    @dateperson = params[:dateform][:date_id]
    if @date.present? and @dateperson.present? 
        @datingtime = Dating.where("time_of_dating = ? AND datable_id= ? ",@date, current_user.id).first
    	if @datingtime == nil
    		@dating = Dating.new(:datable_id => current_user.id,:date_id => @dateperson, :accept => false,:time_of_dating => @date)
    		@dating.save
	     	flash[:notice] = "Request sent for ask date to this person"
	        redirect_to new_user_dating_path(current_user)
	  	   else
	  	   	flash[:notice] = "You already have a date on this day."	  	
	        redirect_to new_user_dating_path(current_user)
	  	 end	    	
    else
	      	flash[:notice] = "Select Date or dating person"
	        redirect_to new_user_dating_path(current_user)
    end
  end

  def request_for_date
  	@dating = Dating.where("date_id = ? AND accept = ?",current_user.id,false)
  end

  def accept_date
    @dating = Dating.where("datable_id = ? AND date_id = ? AND time_of_dating = ?", params[:id].to_i, current_user.id.to_i, params[:date]).first
    if @dating
        @dating.accept = true
        @dating.save
        redirect_to request_for_date_path
        flash[:notice] = "Date accepted Successfully"
    else
        redirect_to request_for_date_path
        flash[:notice] = "Date not found"
    end
  end
  def destroy
    @dating = Dating.where("time_of_dating = ? AND (date_id = ? or datable_id = ?)", params[:id], current_user.id.to_i,current_user.id.to_i).first
    if @dating
      @dating.destroy
      redirect_to  new_user_dating_path(current_user)
      flash[:notice] = "Date rejected Successfully"
      else
        redirect_to  new_user_dating_path(current_user)
        flash[:notice] = "Something wrong"
    end
  end
end
