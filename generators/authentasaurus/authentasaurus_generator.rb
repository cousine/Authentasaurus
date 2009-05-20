require File.expand_path(File.dirname(__FILE__) + "/lib/routes_funcs.rb")
class AuthentasaurusGenerator < Rails::Generator::NamedBase
  default_options :skip_validation => false

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_name, "#{class_name}Test"

      # Controller, View , Model, test, and fixture directories.
      m.directory File.join('app/controllers', class_path)
      m.directory File.join('app/helpers', class_path)
      m.directory File.join('app/views', class_path)
      m.directory File.join('app/models', class_path)
      m.directory File.join('test/unit', class_path)
      m.directory File.join('test/fixtures', class_path)
      m.directory File.join('test/functional', class_path)
      # Other directories
      m.directory "app/views/#{file_name}_sessions"
	  m.directory "app/views/#{file_name.pluralize}"
	  m.directory "app/views/groups"
	  m.directory "app/views/areas"
	  m.directory "app/views/permissions"
      m.directory "app/views/validation_emailer"
	  m.directory "app/views/validations"
      m.directory "test/unit/helpers"
      m.directory "test/fixtures/validation_emailer"

      # Model class
      m.template 'models/user.rb', File.join('app/models', class_path, "#{file_name}.rb")
      m.template 'models/user_session.rb', File.join('app/models', class_path, "#{file_name}_session.rb")
	  m.template 'models/group.rb', File.join('app/models', class_path, "group.rb")
      m.file 'models/area.rb', File.join('app/models', class_path, "area.rb")
      m.file 'models/permission.rb', File.join('app/models', class_path, "permission.rb")

      # Unit tests
      m.template 'unit/user_test.rb',  File.join('test/unit', class_path, "#{file_name}_test.rb")
      m.template 'unit/helpers/user_session_helper_test.rb',  File.join('test/unit/helpers', class_path, "#{file_name}_session_helper_test.rb")
      m.file 'unit/area_test.rb', File.join('test/unit', class_path, "area_test.rb")
      m.file 'unit/group_test.rb', File.join('test/unit', class_path, "group_test.rb")
      m.file 'unit/permission_test.rb', File.join('test/unit', class_path, "permission_test.rb")

      # Fixtures
      m.file 'fixtures/areas.yml', File.join('test/fixtures', class_path, "areas.yml")
      m.file 'fixtures/groups.yml', File.join('test/fixtures', class_path, "groups.yml")
      m.file 'fixtures/permissions.yml', File.join('test/fixtures', class_path, "permissions.yml")
      m.file 'fixtures/users.yml', File.join('test/fixtures', class_path, "#{file_name.pluralize}.yml")

      # Controllers
      m.template 'controllers/user_sessions_controller.rb', File.join('app/controllers', class_path, "#{file_name}_sessions_controller.rb")
	  m.template 'controllers/users_controller.rb', File.join('app/controllers', class_path, "#{file_name.pluralize}_controller.rb")
	  m.template 'controllers/groups_controller.rb', File.join('app/controllers', class_path, "groups_controller.rb")
	  m.template 'controllers/areas_controller.rb', File.join('app/controllers', class_path, "areas_controller.rb")
	  m.template 'controllers/permissions_controller.rb', File.join('app/controllers', class_path, "permissions_controller.rb")

      # Functional
      m.template 'functional/user_sessions_controller_test.rb', File.join('test/functional', class_path, "#{file_name}_sessions_controller_test.rb")

      # Helpers
      m.template 'helpers/user_sessions_helper.rb', File.join('app/helpers', class_path, "#{file_name}_sessions_helper.rb")

      # Views
		## user sessions
      m.file 'views/user_sessions/new.html.erb', File.join("app/views/#{file_name}_sessions", class_path, "new.html.erb")
      m.file 'views/user_sessions/no_access.html.erb', File.join("app/views/#{file_name}_sessions", class_path, "no_access.html.erb")
		## users
	  m.file 'views/users/edit.html.erb', File.join("app/views/#{file_name.pluralize}", class_path, "edit.html.erb")
	  m.file 'views/users/index.html.erb', File.join("app/views/#{file_name.pluralize}", class_path, "index.html.erb")
	  m.file 'views/users/new.html.erb', File.join("app/views/#{file_name.pluralize}", class_path, "new.html.erb")
	  m.file 'views/users/show.html.erb', File.join("app/views/#{file_name.pluralize}", class_path, "show.html.erb")
		## groups
	  m.template 'views/groups/show.html.erb', File.join('app/views/groups', class_path, "show.html.erb")
	  m.file 'views/groups/index.html.erb', File.join("app/views/groups", class_path, "index.html.erb")
	  m.file 'views/groups/edit.html.erb', File.join("app/views/groups", class_path, "edit.html.erb")
	  m.file 'views/groups/new.html.erb', File.join("app/views/groups", class_path, "new.html.erb")
		## areas
	  m.file 'views/areas/edit.html.erb', File.join("app/views/areas", class_path, "edit.html.erb")
	  m.file 'views/areas/index.html.erb', File.join("app/views/areas", class_path, "index.html.erb")
	  m.file 'views/areas/new.html.erb', File.join("app/views/areas", class_path, "new.html.erb")
	  m.file 'views/areas/show.html.erb', File.join("app/views/areas", class_path, "show.html.erb")
		## permissions
	  m.file 'views/permissions/edit.html.erb', File.join("app/views/permissions", class_path, "edit.html.erb")
	  m.file 'views/permissions/index.html.erb', File.join("app/views/permissions", class_path, "index.html.erb")
	  m.file 'views/permissions/new.html.erb', File.join("app/views/permissions", class_path, "new.html.erb")
	  m.file 'views/permissions/show.html.erb', File.join("app/views/permissions", class_path, "show.html.erb")

	  # Routes
      
      m.route_name('login', '/login', { :controller => "#{file_name}_sessions", :action => 'new'})
	  m.route_name('logout', '/logout', { :controller => "#{file_name}_sessions", :action => 'destroy', :id => 1})
      m.route_name('no_access', '/no_access', { :controller => "#{file_name}_sessions", :action => 'no_access'})
      m.route_resources "#{file_name}_sessions"
	  m.route_resources "#{file_name.pluralize}"
	  m.route_resources "groups"
	  m.route_resources "areas"
	  m.route_resources "permissions"

      # Validations
      unless options[:skip_validation]
        # Models
       	m.template 'models/validation.rb', File.join('app/models', class_path, "validation.rb")
        m.file 'models/validation_emailer.rb', File.join('app/models', class_path, "validation_emailer.rb")

        # Unit tests
        m.file 'unit/validation_test.rb', File.join('test/unit', class_path, "validation_test.rb")
        m.file 'unit/validation_emailer_test.rb', File.join('test/unit', class_path, "validation_emailer_test.rb")

        # Fixtures
        m.file 'fixtures/validations.yml', File.join('test/fixtures', class_path, "validations.yml")
        m.file 'fixtures/validation_emailer/validation_mail', File.join('test/fixtures/validation_emailer', class_path, "validation_mail")
		
		# Controllers
		m.template 'controllers/validations_controller.rb', File.join('app/controllers', class_path, "validations_controller.rb")

        # Views
		m.file 'views/validations/index.html.erb', File.join("app/views/validations", class_path, "index.html.erb")
        m.file 'views/validation_emailer/validation_mail.erb', File.join("app/views/validation_emailer", class_path, "validation_mail.erb")
		
		# Routes
		m.route_name('validate', '/validate', { :controller => "validations", :action => 'index'})
      end
	  
	  # Migrations
      m.migration_template 'migrations/create_authentasaurus_tables.rb', 'db/migrate', :migration_file_name => "create_authentasaurus_tables"
	  

    end
  end

  protected
  def banner
      "Usage: #{$0} #{spec.name} MainUserModelName"
  end

  def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--skip-validation",
             "Don't add validation to authentasaurus") { |v| options[:skip_validation] = v }
  end

  private
  def gsub_file(relative_destination, regexp, *args, &block)
    path = destination_path(relative_destination)
    content = File.read(path).gsub(regexp, *args, &block)
    File.open(path, 'wb') { |file| file.write(content) }
  end
end