require "spec_helper"

describe MyGists::Cache::Tags::Helper do

  describe ".slug_from_hashtag" do
    let(:tag_name) { "Rails" }
    let(:hashtag) { "##{tag_name}" }

    subject(:data) { described_class.slug_from_hashtag(hashtag) }

    before(:each) { MyGists::Cache.stub(:read).with(:tags).and_return(cache) }

    context "tag exists" do

      let(:tag_slug) { "rails" }
      let(:tag_key) { "rails" }

      context "tag is in the cache" do

        let(:cache) { { tag_key => { name: tag_name, slug: tag_slug, public: true } } }
        let(:slug) { cache[tag_key][:slug] }

        it "fetches slug from tag cache metadata" do
          ActsAsTaggableOn::Tag.should_not_receive(:find_by_name).with(tag_name)
          data.should eq(slug)
        end
      end

      context "tag is not in the cache" do

        let(:cache) { {} }
        let(:tag) { FactoryGirl.create(:tag, name: tag_name) }
        let!(:slug) { tag.slug }

        it "defaults to getting tag from the database" do
          ActsAsTaggableOn::Tag.should_receive(:find_by_name).with(tag_name).and_return(tag)
          data.should eq(slug)
        end
      end
    end

    context "tag does not exist" do

      let(:cache) { {} }

      it "failed attempt at reading slug returns nil" do
        data.should be_nil
      end
    end
  end
end
