require 'rails_helper'

RSpec.describe '<%= controller_class_name %>Controller', :type => :request do
  describe 'GET /<%= plural_name %>' do

    context 'user is not created' do
      it 'returns a 401 if user is not authenticated' do
        response = oauth_get api_v1_<%= plural_name %>_path
        expect(response.status).to eq 401
      end
    end

    context 'user created' do
      before(:each) do
        @user = create(:admin)
        prepare_user_oauth @user
      end

      it 'returns a list of <%= plural_name %>' do
        <%= singular_name %> = create(:<%= singular_name %>)

        response = oauth_get api_v1_<%= plural_name %>_path, { page_size: 10 }
        expect(response.status).to eq 200

        json_response = JSON.parse response.body

        expect(json_response['<%= plural_name %>']).to_not be_empty
        expect(json_response['<%= plural_name %>'].length).to eq 1
      end
    end
  end

  describe 'POST /<%= plural_name %>' do
    context 'user is not created' do
      it 'returns a 401 if user is not authenticated' do
        posted_data = {
          <%= mock_editable_attribute_key %>: <%= mock_editable_attribute_value %>
        }
        response = oauth_post api_v1_<%= plural_name %>_path, { <%= singular_name %>: posted_data }
        expect(response.status).to eq 401
      end
    end

    context 'user created' do
      it 'creates a <%= singular_name %> for authenticated user' do
        user = create(:admin)
        prepare_user_oauth user

        posted_data = {
          <%= mock_editable_attribute_key %>: <%= mock_editable_attribute_value %>
        }

        response = oauth_post api_v1_<%= plural_name %>_path, { <%= singular_name %>: posted_data }
        expect(response.status).to eq 201

        json_response = JSON.parse response.body

        expect(json_response['id']).to be_a Numeric
        expect(json_response['<%= mock_editable_attribute_key %>']).to eq <%= mock_editable_attribute_value %>
      end
    end
  end

  describe 'PUT /<%= plural_name %>/:id' do
    context 'user is not created' do
      it 'returns a 401 if user is not authenticated' do
        <%= singular_name %> = create(:<%= singular_name %>)
        response = oauth_put api_v1_<%= singular_name %>_path(<%= singular_name %>)
        expect(response.status).to eq 401
      end
    end

    context 'user created' do
      it 'updates a <%= singular_name %> for authenticated user' do
        user = create(:admin)
        <%= singular_name %> = create(:<%= singular_name %>)

        prepare_user_oauth user

        posted_data =  {
          <%= mock_editable_attribute_key %>: <%= mock_editable_attribute_value %>
        }

        response = oauth_put api_v1_<%= singular_name %>_path(<%= singular_name %>), { <%= singular_name %>: posted_data }
        expect(response.status).to eq 200

        json_response = JSON.parse response.body

        expect(json_response['id']).to eq <%= singular_name %>.id
        expect(json_response['<%= mock_editable_attribute_key %>']).to eq <%= mock_editable_attribute_value %>
      end
    end
  end

  describe 'DELETE /<%= plural_name %>/:id' do
    context 'user is not created' do
      it 'returns a 401 if user is not authenticated' do
        <%= singular_name %> = create(:<%= singular_name %>)
        response = oauth_del api_v1_<%= singular_name %>_path(<%= singular_name %>)
        expect(response.status).to eq 401
      end
    end

    context 'user created' do
      it 'updates a <%= singular_name %> for authenticated user' do
        user = create(:admin)
        <%= singular_name %> = create(:<%= singular_name %>)

        prepare_user_oauth user

        response = oauth_del api_v1_<%= singular_name %>_path(<%= singular_name %>)
        expect(response.status).to eq 200

        json_response = JSON.parse response.body

        expect(json_response['message']).to eq '<%= human_name %> deleted'
      end
    end
  end
end
