class NotificationController < ApplicationController

	def list_notifications
		@user = User.find(params[:id])
		@notifications = Notification.where(" receiver = ? and user_id != ? and pending = ?",current_user.id,current_user.id,true).order('created_at desc')	
		@old_notifications = Notification.where(" receiver = ? and user_id != ? and pending = ?",current_user.id,current_user.id,false).order('created_at desc')	
	end

	def show_notifications
		@user = User.find(params[:user_id])
		@article = Article.find(params[:id])
        @notification = Notification.find(params[:noti_id])
        @notification.update_attributes(:pending=> false)
	end

	def destroy
		 @user = User.find(params[:user_id])
		 @notification = Notification.find(params[:id])
		 @notification.destroy
		 redirect_to notification_path(@user)
	end

end
