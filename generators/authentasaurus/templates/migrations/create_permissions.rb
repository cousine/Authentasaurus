class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.integer :group_id, :null => false
      t.integer :area_id, :null => false
      t.boolean :read, :null => false
      t.boolean :write, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
