require 'digest/sha1'
class <%= class_name %> < ActiveRecord::Base
  belongs_to :group
  has_many :permissions, :through => :group
  <% unless options[:skip_validation] -%>
  has_one :validation, :dependent => :destroy
  <% end -%>

  # Check that everything is there
  validates_presence_of :username,:hashed_password, :password_seed, :name,:email, :group_id
  # Check if user is unique
  validates_uniqueness_of :username, :email
  # Check foreign keys
  validates_associated :group, :permissions
  # Check email format
  validates_format_of :email, :with => %r{[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}}
  # Check Password format (very secure password) -ON CREATE-
  validates_presence_of :password, :on => :create
  validates_length_of :password, :minimum => 6, :on => :create
  validates_format_of :password, :with => %r{[a-z]}, :message => "must contain lower case characters", :on => :create
  validates_format_of :password, :with => %r{[A-Z]}, :message => "must contain higher case characters", :on => :create
  validates_format_of :password, :with => %r{[0-9]}, :message => "must contain digits", :on => :create
  validates_format_of :password, :with => %r{[@$%!&]}, :message => "must contain one of the symbols: @$%!&", :on => :create
  validates_confirmation_of :password, :on => :create
  # Check Password format (new password) -ON UPDATE-
  validates_length_of :new_password, :minimum => 6, :on => :update, :unless => :new_password == ""
  validates_format_of :new_password, :with => %r{[a-z]}, :message => "must contain lower case characters", :on => :update, :unless => :new_password == ""
  validates_format_of :new_password, :with => %r{[A-Z]}, :message => "must contain higher case characters", :on => :update, :unless => :new_password == ""
  validates_format_of :new_password, :with => %r{[0-9]}, :message => "must contain digits", :on => :update, :unless => :new_password == ""
  validates_format_of :new_password, :with => %r{[@$%!&]}, :message => "must contain one of the symbols: @$%!&", :on => :update, :unless => :new_password == ""
  validates_confirmation_of :new_password, :on => :update, :unless => :new_password == ""

  <% unless options[:skip_validation] -%>
  # Create validation on create
  after_create :create_validation
  <% end -%>


  # Confirmation attributes
  attr_accessor :password_confirmation, :new_password_confirmation

  # Password attribute (used when creating a user)
  def password
    return @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_salt
    self.hashed_password = User.encrypt_password(@password, self.password_seed)
  end

  # New password attribute (used when editing a user)
  def new_password
    return @new_password
  end
  
  def new_password=(pwd)
    @new_password = pwd
    return if pwd.blank?
    create_salt
    self.hashed_password = User.encrypt_password(@new_password, self.password_seed)
  end

  # Authenticates the username and password
  def self.authenticate(username, password)
    user=self.find_by_username username
    if user
      expected_password=encrypt_password(password, user.password_seed)
      user = nil unless expected_password == user.hashed_password && self.active
      <% unless options[:skip_validation] -%>
      user = nil unless user.validation.nil?
      <% end -%>
    end
    return user
  end

  private
  <% unless options[:skip_validation] -%>
  def create_validation
    validation = Validation.new(:user_id => self.id, :validation_code => User.encrypt_password(self.username,self.password_seed))
    unless validation.save
      raise "Could not create validation record"
    end
  end
  <% end -%>

  # Creates password seed (salt)
  def create_salt
    self.password_seed = self.object_id.to_s + rand.to_s
  end

  # Encrypts the password using the given seed
  def self.encrypt_password(password, password_seed)
    pass_to_hash=password + "Securasaurus" + password_seed
    Digest::SHA1.hexdigest(pass_to_hash)
  end
  
end
