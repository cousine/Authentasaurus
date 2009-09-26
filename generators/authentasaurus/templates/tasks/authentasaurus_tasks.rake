namespace :authentasaurus do
    
    desc "Create the default groups, permissions and users"

    task :load_defaults => :environment do

				puts "Creating groups.."
        puts "Creating Administrators group.."
				administrators_group = Group.create! :name => "Administrators"
        puts "Creating Moderators group.."
				Group.create! :name => "Moderators"
        puts "Creating Users group.."
				Group.create! :name => "Users"
				
				puts "Creating areas.."
				puts "Creating super area (all).."
				all_areas = Area.create :name => "all"
				puts "Creating pages area.."
				Area.create :name => "page"
				

				puts "Granting permissions.."
				puts "Granting all permissions to Administrators group.."
        Permission.create! :group_id => administrators_group.id, :area_id => all_areas.id, :read => true, :write => true

				puts "Creating admin user.."
        User.create! :username => "admin", :password => "Pass@123", :name => "Administrator",
          :email => "admin@your-domain.com", :active => true, :group_id => administrators_group.id
      
    end
end