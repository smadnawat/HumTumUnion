class MessagesController < ApplicationController

	def new
        @reciever = User.find(params[:user_id]) 
		@current_user_messages =  current_user.messages.where("reciever = ? ",@reciever.id).pluck(:id)
		@reciever_messages = @reciever.messages.where("reciever = ? ",current_user.id).pluck(:id)
		@all_old_messages_id = @current_user_messages + @reciever_messages
		@all_old_messages = Message.where("id IN (?)",@all_old_messages_id).order("created_at desc")

		@current_user_messages = Message.where("reciever = ? and user_id = ? and unread =?",current_user.id,@reciever.id,"unread")
		@current_user_messages.each do |m|
			m.unread = "read"
			m.save
		end
	end


	def create
	   @reciever = User.find(params[:user_id]) 
	   @message = params[:message][:content]
	   @image = params[:message][:image]
	   if @message != '' or @image != nil
		   @message = current_user.messages.create(:content => params[:message][:content],:reciever => @reciever.id,:image => params[:message][:image] , :unread => "unread")
		   if !@message
		   	 flash[:notice] = "Something wrong"
	         render 'new'
	       else
	         redirect_to new_user_message_path(@reciever)
	       end 
	   else
	        redirect_to new_user_message_path(@reciever)
	    end  	
	end

	def new_group_message
        @sender = User.find(params[:sender]) 
        @group = Group.find(params[:id])
        @old_group_messages = @group.messages.order("created_at desc")
		 @current_user_messages = Message.where("user_id != ? and unread = ? and group_id = ?",current_user.id,'unread',@group.id)

 		 @current_user_messages.each do |m|
		 	m.unread = "read"
		 	m.save
		end
	end

	def group_message
		@sender = User.find(params[:sender]) 
        @group = Group.find(params[:id])
        @message = params[:group_message][:content]
	    @image = params[:group_message][:image]
		   if @message != '' or @image != nil
			   @message = current_user.messages.create(:content => params[:group_message][:content],:group_id => @group.id,:image => params[:group_message][:image] , :unread => "unread")
			   if !@message
			   	 flash[:notice] = "Something wrong"
		         render new_group_message_path(@sender,@group)
		       else
		         redirect_to new_group_message_path(@sender,@group)
		       end 
		   else
		        redirect_to new_group_message_path(@sender,@group)
		    end  	
	end


	def index
		@reciever = User.find(params[:user_id]) 
		@unread_messages =  Message.where("(reciever = ? and unread = ?) or ( user_id != ? and unread = ? and group_id != ?)",current_user.id,"unread",current_user.id,"unread",0)
	end


	def inbox
		@user = User.find(params[:id])
		@to = @user.messages.pluck(:reciever).uniq
		@from = Message.where("reciever = ?",@user.id).pluck(:user_id).uniq
		@all_users = @to + @from
		@conversation_with = User.where("id IN (?)",@all_users).order("name asc")
	end


	def delete_conversion
		@user = User.find(params[:id])
		@send_messages = current_user.messages.where("reciever = ? ",@user.id)
		@recieved_messages = @user.messages.where("reciever = ?",current_user.id)
		@send_messages.destroy_all
		@recieved_messages.destroy_all
		flash[:notice]= "Conversation deleted successfully with #{@user.name}"
		redirect_to inbox_path(current_user)
	end

	def destroy
		@user = User.find(params[:user_id])
		@message = 	Message.find(params[:id])
	    @message.destroy
	    redirect_to new_user_message_path(@user)
	end
end
