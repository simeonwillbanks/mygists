module MyGists

  # Public: Search terms have a finite list of exact matches, and these exact
  #         matches are auto-suggested to users. This class provides a clear
  #         interface to those terms.
  #
  # Examples
  #
  #   MyGists::Search::Terms.tags
  #
  #   MyGists::Search::Terms.profiles
  class Search::Terms

    # Public: Get all possible tag search terms.
    #
    # Examples
    #
    #   MyGists::Search::Terms.tags
    #   # => ["github"]
    #
    # Returns the Array of tags.
    def self.tags
      MyGists::Cache.read(:tags).inject([]) do |names, (_, meta)|
        names << meta[:name] if meta[:public] == true
        names
      end
    end

    # Public: Get all possible profile search terms.
    #
    # Examples
    #
    #   MyGists::Search::Terms.profiles
    #   # => ["simeonwillbanks"]
    #
    # Returns the Array of profiles.
    def self.profiles
      MyGists::Cache.read(:profiles)
    end
  end
end
