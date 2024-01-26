# frozen_string_literal: true

module Api
  module V2
    class PaginateArray
      def self.call(collection, params)
        new(collection, params).call
      end

      def initialize(collection, params)
        @collection = collection
        @page       = params[:page].presence || 1
        @per_page   = params[:per_page].presence || 25
      end

      def call
        paginated_result = paginated_by_per_page(collection)
        {
          data: paginated_result,
          meta: meta_builder(paginated_result),
        }
      end

      private

      attr_reader :collection, :page, :per_page

      def paginated_by_per_page(result)
        Kaminari.paginate_array(result.to_a).page(page).per(per_page)
      end

      def meta_builder(result)
        {
          count: result.size,
          total_count: result.total_count,
          total_pages: result.total_pages,
        }
      end
    end
  end
end
