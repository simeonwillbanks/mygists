module MyGists

  # Public: Simple data container for cached tag slug and state.
  #
  # Examples
  #
  #   Meta.new("rails", true)
  #   # => #<struct MyGists::Cache::Tags::Meta name="rails", slug="rails", public=true>
  class Cache::Tags::Meta < Struct.new(:name, :slug, :public)
  end
end
