require 'generators/rails_base_api_scaffold/generator_helpers'

module RailsBaseApiScaffold
  module Generators
    # Custom scaffolding generator
    class ControllerGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      include RailsBaseApiScaffold::Generators::GeneratorHelpers
  
      desc "Generates controller, controller spec, route, and serializer for the model with the given NAME."
      
      source_root File.expand_path('../templates', __FILE__)
      
      def copy_templates
        template "controller.rb", File.join("app/controllers/api/v1", "#{controller_file_name}_controller.rb")
        template "serializer.rb", File.join("app/serializers", "#{file_name}_serializer.rb")
        template "spec.rb", File.join("spec/requests/api/v1", "#{controller_file_name}_controller_spec.rb")
      end
      
      def add_routes
        # Include tabs and line break for proper formatting
        routes_string = "      resources :#{plural_name}\n"
        # Inject into file following the api and v1 namespaces
        inject_into_file 'config/routes.rb', after: "  namespace :api do\n    namespace :v1 do\n" do
          routes_string
        end
      end

      def add_scoped_search
        scoped_search_string = "  scoped_search on: [ :id, :created_at, :updated_at ], only_explicit: true\n"
        inject_into_file "app/models/#{file_name}.rb", after: "class #{class_name} < ActiveRecord::Base\n" do
          scoped_search_string
        end
      end
    end
  end
end