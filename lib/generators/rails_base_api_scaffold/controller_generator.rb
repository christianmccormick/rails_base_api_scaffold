require 'generators/rails_base_api_scaffold/generator_helpers'

module RailsBaseApiScaffold
  module Generators
    # Custom scaffolding generator
    class ControllerGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      include RailsBaseApiScaffold::Generators::GeneratorHelpers
  
      desc "Generates controller, controller_spec and views for the model with the given NAME."
      
      source_root File.expand_path('../templates', __FILE__)
      
      def copy_controller_and_spec_files
        template "controller.rb", File.join("app/controllers/api/v1", "#{controller_file_name}_controller.rb")
      end
      
      def add_routes
        # Include tabs and line break for proper formatting
        routes_string = "      resources :#{singular_name}\n"
        # Inject into file following the api and v1 namespaces
        inject_into_file 'config/routes.rb', after: "  namespace :api do\n    namespace :v1 do\n" do
          routes_string
        end
      end
    end
  end
end