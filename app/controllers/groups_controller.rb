class GroupsController < ApplicationController

    def new
     @user = User.find(params[:user_id])	
    end

	def create
	  @user = User.find(params[:user_id])
	  @group= Group.create(:name => params[:group][:name],:admin => @user.id)
	  if @group
	  	add = @group.users << @user
	  	flash[:notice] = "Group created"
	  	redirect_to user_group_path(@user,@group)
	  else
	  	flash[:notice] = "Somthing wrong"
	  	render 'new'
	  end
	end

	def show 
		@user = User.find(params[:user_id])
		@group = Group.find(params[:id])
	end

	def index
		@user = User.find(params[:user_id])
		@group = Group.where("admin = ?",@user.id)
		@groups= @user.groups.where("admin !=?",@user.id)
	end

	def edit
		@user = User.find(params[:user_id])
		@group = Group.find(params[:id])
	end

	def update
		@user = User.find(params[:user_id])
		@group = Group.find(params[:id])
		@group.name = params[:group][:name]
		add = @group.users << @user
		if @group.save and add
	  	flash[:notice] = "Group updated"
	  	redirect_to  user_group_path(@user,@group)
	  else
	  	flash[:notice] = "Somthing wrong"
	  	render 'new'
	  end
	end

	def add_group_member
		@user = User.find(params[:user_id])
		@group = Group.find(params[:group_id])
	end

	def add_member
		@group = Group.find(params[:group_id])
		@member = User.find(params[:member_id])
		if @group.users.include?(@member) # if user already exist in this group at users_groups then remove from group
			@remove_member = @group.users.find_by_id(@member.id)
			sqlqueryy = "delete from users_groups where user_id = #{@remove_member.id} and group_id = #{@group.id}"
			queryy = ActiveRecord::Base.connection.execute(sqlqueryy)
			flash[:notice] = "You removed #{@remove_member.name}"
			redirect_to add_group_member_path(current_user,@group)			
		else
			if @group.users << @member    # add member to users_groups table
				flash[:notice] = "#{@member.name} added successsfully"
				redirect_to add_group_member_path(current_user,@group)
			else
				flash[:notice] = "Somthing wrong"
				redirect_to add_group_member_path(current_user,@group)
			end
		end
	end

	def search_group
		@user = User.find(current_user)
		@groups = Group.where('name LIKE ?', "%#{params[:search_group][:search]}%");
	end

	def search_person
		@user = User.find(current_user)
		@group = Group.find(params[:group_id])
		@users = User.where('name LIKE ?', "%#{params[:search_users][:users]}%");
	end

	def join_group
		@group = Group.find(params[:group_id])
		@member = User.find(params[:user_id])
		if @group.users.include?(@member)
			@remove_member = @group.users.find_by_id(@member.id)
			sqlqueryy = "delete from users_groups where user_id = #{@remove_member.id} and group_id = #{@group.id}"
			queryy = ActiveRecord::Base.connection.execute(sqlqueryy)
			flash[:notice] = "You left #{@group.name} group"
			redirect_to user_groups_path(current_user)			
		else
			if @group.users << @member
				flash[:notice] = "You joined #{@group.name} group"
				redirect_to user_groups_path(current_user)
			else
				flash[:notice] = "Somthing wrong"
				redirect_to user_groups_path(current_user)
			end
		end
	end

	def show_group
		@user = User.find(params[:user_id])
		@group = Group.find(params[:group_id])
	end

	def destroy
		@user = User.find(params[:user_id])
		@group = Group.find(params[:id])
		if @group.destroy
			flash[:notice] = "Group deleted"
		  	redirect_to user_groups_path(@user)
		else
			flash[:notice] = "something wrong"
		  	redirect_to user_group_path(@user,@group)
		end
	end



end
