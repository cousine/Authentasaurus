class <%= class_name %>SessionsController < ApplicationController
  require_login <%= ":model => :#{class_name}, " unless class_name == "User" %>:actions => :destroy, :skip_request => true

  # creates a new user session (login)
  def new
    @session_object = <%= class_name %>Session.new

    respond_to do |format|
      format.html { redirect_to "" if is_logged_in?	}
    end
  end

  # authenticating
  def create
    @session_object = <%= class_name %>Session.new(params[:<%= file_name %>_session])

    respond_to do |format|
      if @session_object.login(session)
        uri =session[:original_url]
        session[:original_url]=nil
        format.html { redirect_to(uri || "" ) }
      else
        flash.now[:notice] = "Invalid username/password combination"
        format.html { render :new }
      end
    end
  end

  # logout
  def destroy
    @session_object = nil
    session[:user_id]= nil
    session[:permissions]= nil
    session[:guest_permissions]= nil

    respond_to do |format|
      format.html {redirect_to login_url}
    end
  end

  def no_access
    
  end
end
