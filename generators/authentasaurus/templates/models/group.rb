class Group < ActiveRecord::Base
  has_many :<%= class_name.downcase.pluralize %>, :dependent => :destroy
  has_many :permissions, :dependent => :destroy
  has_many :areas, :through => :permissions

  # Check that everything is there
  validates_presence_of :name
  
end
