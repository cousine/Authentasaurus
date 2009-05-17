class <%= class_name %>SessionsController < ApplicationController
  require_login :actions => :destroy, :skip_request => true

  # creates a new user session (login)
  def new
    @session_object = <%= class_name %>Session.new

    respond_to do |format|
      format.html
    end
  end

  # authenticating
  def create
    @session_object = <%= class_name %>Session.new(params[:<%= file_name %>_session])

    if request.post?
      if @session_object.login(session)
        uri =session[:original_url]
        session[:original_url]=nil
        redirect_to(uri || "" )
      else
        flash.now[:notice] = "Invalid username/password combination"
        render :new
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
      format.html {redirect_to :new}
    end
  end

  def no_access
    
  end
end
