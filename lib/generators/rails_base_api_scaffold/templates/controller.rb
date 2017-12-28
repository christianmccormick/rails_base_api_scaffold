module Api::V1
    class <%= controller_class_name %>Controller < ApiController
      respond_to :json
  
      check_authorization
  
      before_action :doorkeeper_authorize!, except: :me
  
      skip_before_filter :verify_authenticity_token
  
      load_and_authorize_resource
  
      helper_method :sort_order, :sort_column, :sort_direction
  
      # GET /<%= plural_name %>/
      def index
  
        page_size = params[:page_size] ? params[:page_size].to_i : 20
  
        raise RangeError.new("invalid page_size: #{page_size}") if page_size < 1
  
        @<%= plural_name %> = <%= class_name %>.search_for(params[:search], order: sort_order).paginate(page: params[:page], per_page: page_size)
  
        page_counts = @<%= plural_name %>.total_entries.divmod(page_size)
        page_count = page_counts[0] + ((page_counts[1] > 0) ? 1 : 0)
  
        render json: @<%= plural_name %>,
               root: '<%= plural_name %>',
               meta: { page_count: page_count, page_size: page_size }, adapter: :json
  
      end
  
      # GET /<%= plural_name %>/1
      def show
        render json: @<%= singular_name %>, serializer: <%= class_name %>Serializer, root: false
      end
  
      # POST /<%= plural_name %>/1
      def create
        <%= singular_name %> = <%= class_name %>.create(<%= singular_name %>_params)

        if <%= singular_name %>
          render json: <%= singular_name %>, serializer: <%= class_name %>Serializer, status: :created
        else
          render json: <%= singular_name %>.errors, status: :unprocessable_entity
        end
      end
  
      # PUT /<%= plural_name %>/1
      def update
        if @<%= singular_name %>.update(<%= singular_name %>_params)
          render json: @<%= singular_name %>, serializer: <%= class_name %>Serializer, status: :ok
        else
          render json: @<%= singular_name %>.errors, status: :unprocessable_entity
        end
      end
  
      # DELETE /<%= plural_name %>/1
      def destroy
        @<%= singular_name %>.destroy
        render json: { message: '<%= human_name %> deleted' }
      end
  
      private
  
      # Add index sorting by default
      def sort_order
        sort_column + ' ' + sort_direction
      end
  
      def sort_column
        <%= class_name %>.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
      end
  
      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
      end
  
      # Only allow a trusted parameter "white list" through.
      def <%= singular_name %>_params
        params.require(:<%= singular_name %>).permit([<%= editable_attributes.map { |a| ":#{a.name}" }.join(', ') %>])
      end
    end
  end
  