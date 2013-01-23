module MyGists

  # Public: Simple data container for cached tag name, slug and state.
  #
  # Examples
  #
  #   Meta.new("Rails", "rails", true)
  #   # => #<struct MyGists::Cache::Tags::Meta name="Rails", slug="rails", public=true>
  class Cache::Tags::Meta < Struct.new(:name, :slug, :public)
  end
end
