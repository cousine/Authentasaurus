class CreateValidations < ActiveRecord::Migration
  def self.up
    create_table :validations do |t|
      t.integer :<%= file_name %>_id, :null => false
      t.string :validation_code, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :validations
  end
end
