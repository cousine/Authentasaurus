class <%= class_name %>Session
  attr_accessor :username, :password, :errors

  def initialize(opts={})
    @errors =  ActiveRecord::Errors.new(self)
    @username = opts[:username] if opts[:username]
    @password = opts[:password] if opts[:password]
  end

  def login(session)
    user = <%= class_name %>.authenticate(@username, @password)
    if user
      session[:user_id]= user.id
      session[:permissions]= user.permissions
      session[:guest_permissions]= Group.find_by_name("Everyone").permissions
      return true
    end
    return false
  end

  def new_record?
    true
  end
end