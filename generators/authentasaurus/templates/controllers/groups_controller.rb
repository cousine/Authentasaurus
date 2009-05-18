class GroupsController < ApplicationController
	require_read :model => <%= class_name %>,:actions => [:index, :show]
	require_write :model => <%= class_name %>,:actions => [:new, :create, :edit, :update, :destroy]
	
	def index
		@groups = Group.find :all
		
		respond_to do |format|
			format.html
		end
	end
	
	def show
		@group = Group.find params[:id]
		
		respond_to do |format|
			format.html
		end
	end
	
	def new
		@group = Group.new
		
		respond_to do |format|
			format.html
		end
	end
	
	def create
		@group = Group.new params[:group]
		
		if request.post?
			if @group.save
				flash.now[:notice] = "Group created"
				redirect_to :index
			else
				flash.now[:notice] = "Error creating group"
				render :new
			end
		end
	end
	
	def edit
		@group = Group.find params[:id]
		
		respond_to do |format|
			format.html
		end
	end
	
	def update
		@group = Group.find params[:id]
		
		if request.post?
			if @group.update_attributes(params[:group])
				flash.now[:notice] = "Group updated"
				redirect_to @group
			else
				flash.now[:notice] = "Error updating group"
				render :edit
			end
		end
		
	end
	
	def destroy
		@group = Group.find params[:id]
		@group.destroy
		
		respond_to do |format|
			format.html { redirect_to :index }
		end	
	end
	
end