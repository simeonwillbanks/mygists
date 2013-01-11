module HomeHelper

  # Public: A hash of navigation items for the main navigation partial. These
  #         navigation items are only for the home page.
  #
  # Returns a Hash of navigation items.
  def navigation_items
    { home: root_path }
  end
end
