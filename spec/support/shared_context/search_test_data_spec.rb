shared_context "search test data" do

  let(:search_data) { SearchTestData.generate }

  let(:user) { search_data.user }
  let(:profile) { search_data.profile }

  let(:generic_tag_name) { search_data.generic_tag_name }
  let(:public_tag_name) { search_data.public_tag_name }
  let(:private_tag_name) { search_data.private_tag_name }

  let(:generic_tag) { search_data.generic_tag }
  let(:public_tag) { search_data.public_tag }
  let(:private_tag) { search_data.private_tag }

  let(:public_tag_decorated) { search_data.public_tag_decorated }
  let(:public_tag_decorated) { search_data.public_tag_decorated }
  let(:private_tag_decorated) { search_data.private_tag_decorated }
  let(:generic_tag_decorated) { search_data.generic_tag_decorated }

  let(:public_gist) { search_data.public_gist }
  let(:private_gist) { search_data.private_gist }
  let(:generic_public_gist) { search_data.generic_public_gist }
  let(:generic_private_gist) { search_data.generic_private_gist }

  let(:public_gist_decorated) { search_data.public_gist_decorated }
  let(:private_gist_decorated) { search_data.private_gist_decorated }
  let(:generic_public_gist_decorated) { search_data.generic_public_gist_decorated }
  let(:generic_private_gist_decorated) { search_data.generic_private_gist_decorated }

  let(:generic_tag_cache_key) { MyGists::Cache::Tags.key(generic_tag_name) }
  let(:public_tag_cache_key) { MyGists::Cache::Tags.key(public_tag_name) }
  let(:private_tag_cache_key) { MyGists::Cache::Tags.key(private_tag_name) }

  let(:tags_cache) do
    {
      generic_tag_cache_key => { name: generic_tag.name,
                                 slug: generic_tag.slug,
                                 public: true },
      public_tag_cache_key  => { name: public_tag.name,
                                 slug: public_tag.slug,
                                 public: true },
      private_tag_cache_key => { name: private_tag.name,
                                 slug: private_tag.slug,
                                 public: false }
    }
  end

  let(:profiles_cache) { [profile.username] }

  before(:each) do
    MyGists::Cache.stub(:read).with(:tags).and_return(tags_cache)
    MyGists::Cache.stub(:read).with(:profiles).and_return(profiles_cache)
  end
end
