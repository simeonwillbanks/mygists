class ApplicationDecorator < Draper::Decorator

  # Public: Define a custom collection decorator class which has delegated
  #         WillPaginate required methods to the source.
  #
  # Returns a PaginationDecorator constant.
  def self.collection_decorator_class
    PaginationDecorator
  end
end
