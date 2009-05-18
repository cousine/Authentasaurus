module Authentasaurus

  def require_login (options ={})
    model = options[:model] || User
    user_id = options[:user_id] || :user_id
    login_message = options[:login_message] || "You need to login first."

    define_method "check_logged_in" do
      unless model.find_by_id(session[user_id])
        unless(options[:skip_request])
          session[:original_url]=request.url
        end
        flash[:notice] = login_message
        redirect_to login_url
      end
    end

    private :check_logged_in
	unless :options[:actions] == :all
		before_filter :check_logged_in, :only => options[:actions]
	else
		before_filter :check_logged_in
	end
  end
  
  def require_write(options = {})
    model = options[:model] || User
    user_id = options[:user_id] || :user_id
    user = options[:user_permissions] || :permissions
    guest = options[:guest_permissions] || :guest_permissions
    login_message = options[:login_message] || "You need to login first."

    define_method "check_write" do
      if model.find_by_id(session[user_id])
        user_permissions = session[user]
        guest_permissions = session[guest]
        check = guest_permissions[:write].find { |perm| perm==self.controller_name  } || user_permissions[:write].find { |perm| perm==self.controller_name }
        unless check
          redirect_to no_access_url
        end
      else
        unless(options[:skip_request])
          session[:original_url]=request.url
        end
        flash[:notice] = login_message
        redirect_to login_url
      end
    end

    private :check_write
	unless :options[:actions] == :all
		before_filter :check_logged_in, :only => options[:actions]
	else
		before_filter :check_logged_in
	end
  end

  def require_read(options = {})
    model = options[:model] || User
    user_id = options[:user_id] || :user_id
    user = options[:user_permissions] || :user_permissions
    guest = options[:guest_permissions] || :guest_permissions
    login_message = options[:login_message] || "You need to login first."

    define_method "check_read" do
      if model.find_by_id(session[user_id])
        user_permissions = session[user]
        guest_permissions = session[guest]
        check = guest_permissions[:read].find { |perm| perm==self.controller_name  } || user_permissions[:read].find { |perm| perm==self.controller_name }
        unless check
          redirect_to no_access_url
        end
      else
        unless(options[:skip_request])
          session[:original_url]=request.url
        end
        flash[:notice] = login_message
        redirect_to login_url
      end
    end

    private :check_read
	unless :options[:actions] == :all
		before_filter :check_logged_in, :only => options[:actions]
	else
		before_filter :check_logged_in
	end
  end

end
