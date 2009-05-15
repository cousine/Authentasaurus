class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.string target, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
