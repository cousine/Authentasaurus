class <%= class_name.pluralize %>Controller < ApplicationController
	require_read :model => <%= class_name %>,:actions => [:index, :show]
	require_write :model => <%= class_name %>,:actions => [:new, :create, :edit, :update, :destroy]
	
	def index
		@users = <%= class_name %>.find :all
		
		respond_to do |format|
			format.html
		end
	end
	
	def show
		@user = <%= class_name %>.find(params[:id])
		
		respond_to do |format|
			format.html
		end
	end
	
	def new
		@user = <%= class_name %>.new
		
		respond_to do |format|
			format.html
		end
	end
	
	def create
		@user = <%= class_name %>.new params[:user]
			
		respond_to do |format|
			if @user.save
				flash.now[:notice] = "User saved successfully"
				format.html { redirect_to :action=>:index }
			else
				flash.now[:notice] = "Error saving user"
				format.html { render :new }
			end
		end
	end
	
	def edit
		@user = <%= class_name %>.find params[:id]
		
		respond_to do |format|
			format.html
		end
	end
	
	def update
		@user = <%= class_name %>.find params[:id]
		
		respond_to do |format|
			if @user.update_attributes(params[:user])
				flash.now[:notice] = "User updated"
				format.html { redirect_to @user }
			else
				flash.now[:notice] = "Error updating user"
				format.html { render :edit }
			end
		end
	end
	
	def destroy
		@user = <%= class_name %>.find params[:id]
		@user.destroy
		
		respond_to do |format|
			format.html { redirect_to :action=>:index }
		end
	end
end