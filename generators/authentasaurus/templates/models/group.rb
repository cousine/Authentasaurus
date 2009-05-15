class Group < ActiveRecord::Base
  has_many :<%= class_name.downcase %>, :dependent => :destroy
  has_many :permissions, :dependent => :destroy
  has_many :areas, :through => :permissions

  # Check that everything is there
  validates_presence_of :name
  # Check foreign keys
  validates_associated :<%= class_name.downcase.pluralize %>, :permissions, :areas
  
end
