# frozen_string_literal: true

module Api
  module V2
    module CollectionOptionsHelpers
      def collection_links(collection)
        {
          self: request.original_url,
          next: pagination_url(collection.next_page || collection.total_pages),
          prev: pagination_url(collection.prev_page || 1),
          last: pagination_url(collection.total_pages),
          first: pagination_url(1),
        }
      end

      def collection_meta(collection)
        custom_data = defined?(custom_collection_meta) ? custom_collection_meta : {}

        {
          count: collection.size,
          total_count: collection.total_count,
          total_pages: collection.total_pages,
        }.merge(custom_data)
      end

      # leaving this method in public scope so it's still possible to modify
      # those params to support non-standard non-JSON API parameters
      def collection_permitted_params
        params.permit(:format, :page, :per_page, :sort, :include, :fields, filter: {})
      end

      private

      def pagination_url(page)
        url_for(collection_permitted_params.merge(page:))
      end
    end
  end
end
