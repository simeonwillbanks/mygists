require 'spec_helper'

describe MyGists::Search do

  context "only receives messages via class method" do
    it "sending a message to .new raises an exception" do
      expect { described_class.new }.to raise_exception(NoMethodError)
    end

    it "a message can be sent to .for" do
      described_class.should respond_to(:for)
    end
  end

  context "searching" do

    include_context "search test data"

    it "user searches their tags, they find public and private tags" do
      result = described_class.for(:tags, profile: profile).to_a
      expect(result).to match_array([public_tag_decorated, private_tag_decorated])
    end

    it "user searches another user's tags, public but not private tags are found" do
      result = described_class.for(:tags, profile: profile, private: false).to_a
      expect(result).to match_array([public_tag_decorated])
    end

    it "user searches their gists, they find public and private gists" do
      result = described_class.for(:gists, profile: profile).to_a
      expect(result).to match_array([public_gist_decorated, private_gist_decorated])
    end

    it "user searches another user's gists, public but not find private gists are found" do
      result = described_class.for(:gists, profile: profile, private: false).to_a
      expect(result).to match_array([public_gist_decorated])
    end

    it "user searches their gists by tag, they find public and private gists" do
      search_data.generate_generic
      result = described_class.for(:gists, profile: profile, tag: generic_tag_name).to_a
      expect(result).to match_array([generic_public_gist_decorated, generic_private_gist_decorated])
    end

    it "user searches another user's gists by tag, public but private gists are found" do
      result = described_class.for(:gists, profile: profile, tag: public_tag_name, private: false).to_a
      expect(result).to match_array([public_gist_decorated])
    end
  end
end
