require 'generators/rails_base_api_scaffold/generator_helpers'

module RailsBaseApiScaffold
  module Generators
    # Custom scaffolding generator
    class ControllerGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      include RailsBaseApiScaffold::Generators::GeneratorHelpers
  
      desc "Generates controller, controller_spec and views for the model with the given NAME."
      
      source_root File.expand_path('../templates', __FILE__)
      
      def copy_templates
        template "serializer.rb", File.join("app/serializers", "#{file_name}_serializer.rb")
      end
    end
  end
end