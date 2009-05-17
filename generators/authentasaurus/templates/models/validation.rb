class Validation < ActiveRecord::Base
  belongs_to :<%= file_name %>
  
  # Check that everything is there
  validates_presence_of :user_id, :validation_code
  # Check foreign keys
  validates_associated :user
  # Check unique user
  validates_uniqueness_of :<%= file_name %>_id, :validation_code

  #send email
  after_create :send_validation

  private
  def send_validation
    validation_emailer.validation_mail(self.<%= file_name %>.name, self.<%= file_name %>.email, self.validation_code)
  end
end
