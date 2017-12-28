class <%= class_name %>Serializer < ActiveModel::Serializer
  attributes :id, <%= editable_attributes.map { |a| ":#{a.name}" }.join(', ') %>
end