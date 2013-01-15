shared_context "search test data" do

  let(:search_data) { SearchTestData.generate }

  let(:profile) { search_data.profile }

  let(:generic_tag_name) { search_data.generic_tag_name }
  let(:public_tag_name) { search_data.public_tag_name }
  let(:private_tag_name) { search_data.private_tag_name }

  let(:public_tag_decorated) { search_data.public_tag_decorated }
  let(:private_tag_decorated) { search_data.private_tag_decorated }

  let(:public_gist_decorated) { search_data.public_gist_decorated }
  let(:private_gist_decorated) { search_data.private_gist_decorated }
  let(:generic_public_gist_decorated) { search_data.generic_public_gist_decorated }
  let(:generic_private_gist_decorated) { search_data.generic_private_gist_decorated }

end
