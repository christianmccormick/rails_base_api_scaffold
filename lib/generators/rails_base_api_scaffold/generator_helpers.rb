module RailsBaseApiScaffold
  module Generators
    # Some helpers for generating scaffolding
    module GeneratorHelpers
      attr_accessor :options, :attributes

      private

      def model_columns_for_attributes
        class_name.constantize.columns.reject do |column|
          column.name.to_s =~ /^(id|user_id|created_at|updated_at)$/
        end
      end

      def editable_attributes
        attributes ||= model_columns_for_attributes.map do |column|
          Rails::Generators::GeneratedAttribute.new(column.name.to_s, column.type.to_s)
        end
      end

      def mock_editable_attribute_key
        attribute = editable_attributes.first
        attribute.name
      end

      def mock_editable_attribute_value
        attribute = editable_attributes.first
        attribute.type == 'string' ? '"Test"' :
          attribute.type == 'text' ? '"Test"' :
          attribute.type == 'integer' ? 1 :
          attribute.type == 'float' ? 1.25 :
          attribute.type == 'decimal' ? 1.50 :
          attribute.type == 'datetime' ? '"2017-12-27 00:00:00"' :
          attribute.type == 'time' ? '"00:00:00"' :
          attribute.type == 'date' ? '"2017-12-27"' :
          attribute.type == 'binary' ? '"Test"' :
          attribute.type == 'boolean' ? true :
          nil
      end
    end
  end
end