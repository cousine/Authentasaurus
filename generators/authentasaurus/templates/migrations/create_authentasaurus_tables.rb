class CreateAuthentasaurusTables < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.string :username, :null => false
      t.string :hashed_password, :null => false
      t.string :password_seed, :null => false
      t.string :name, :null => false
      t.string :email, :null => false
      t.boolean :active, :null => false, :default => false
      t.integer :group_id, :null => false

      t.timestamps
    end

    create_table :areas do |t|
      t.string :target, :null => false

      t.timestamps
    end
    
    create_table :groups do |t|
      t.string :name, :null => false

      t.timestamps
    end

    create_table :permissions do |t|
      t.integer :group_id, :null => false
      t.integer :area_id, :null => false
      t.boolean :read, :null => false
      t.boolean :write, :null => false

      t.timestamps
    end

    <% unless options[:skip_validation] -%>
    create_table :validations do |t|
      t.integer :<%= file_name %>_id, :null => false
      t.string :validation_code, :null => false

      t.timestamps
    end
    <% end -%>
  
  end

  def self.down
    drop_table :<%= table_name %>
    drop_table :areas
    drop_table :groups
    drop_table :permissions
    <% unless options[:skip_validation] -%>
    drop_table :validations
    <% end -%>
  end
end
