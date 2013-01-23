class PaginationDecorator < Draper::CollectionDecorator

  # Public: Expose WillPaginate API.
  delegate :current_page, :total_entries, :total_pages, :per_page, :offset
end
