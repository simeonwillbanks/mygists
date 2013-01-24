class PaginationDecorator < Draper::CollectionDecorator

  # Public: Expose Kaminari API.
  delegate :current_page, :total_pages, :limit_value
end
