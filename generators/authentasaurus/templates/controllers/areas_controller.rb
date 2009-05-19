class AreasController < ApplicationController
	require_read :model => <%= class_name %>, :actions => [:index, :show]
	require_write :model => <%= class_name %>, :actions => [:new, :create, :edit, :update, :destroy]
	
	def index
		@areas= Area.find :all
		
		respond_to do |format|
			format.html
		end
	end
	
	def new
		@area = Area.new
		
		respond_to do |format|
			format.html
		end
	end
	
	def create
		@area = Area.new params[:area]
		
		if request.post?
			if @area.save
				flash.now[:notice] = "Area created" 
				redirect_to :index
			else
				flash.now[:notice] = "Error creating area"
				render :new
			end
		end
	end
	
	def edit
		@area = Area.find params[:id]
		
		respond_to do |format|
			format.html
		end
	end
	
	def update
		@area = Area.find params[:id]
		
		if request.post?
			if @area.update_attributes(params[:area])
				flash.now[:notice] = "Area updated"
				redirect_to @area
			else
				flash.now[:notice] = "Error updating area"
				render :edit
			end
		end
	end
	
	def destroy
		@area = Area.find params[:id]
		@area.destroy
		
		respond_to do |format|
			format.html { redirect_to :index }
		end
	end
end