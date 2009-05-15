class Permission < ActiveRecord::Base
  belongs_to :group
  has_one :area

  # Check that everything is there
  validates_presence_of :group_id,:area_id,:read,:write
  # Check foreign keys
  validates_associated :group, :area
end
