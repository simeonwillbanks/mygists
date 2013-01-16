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
      options = { profile: profile }
      tags = [public_tag_decorated, private_tag_decorated, generic_tag_decorated]
      result = described_class.for(:tags, options).to_a
      expect(result).to match_array(tags)
    end

    it "user searches another user's tags, public but not private tags are found" do
      options = { profile: profile, private: false }
      tags = [public_tag_decorated, generic_tag_decorated]
      result = described_class.for(:tags, options).to_a
      expect(result).to match_array(tags)
    end

    it "user searches their gists, they find public and private gists" do
      options = { profile: profile }
      gists = [public_gist_decorated, private_gist_decorated,
               generic_public_gist_decorated, generic_private_gist_decorated]
      result = described_class.for(:gists, options).to_a
      expect(result).to match_array(gists)
    end

    it "user searches another user's gists, public but not find private gists are found" do
      options = { profile: profile, private: false }
      gists = [public_gist_decorated, generic_public_gist_decorated]
      result = described_class.for(:gists, options).to_a
      expect(result).to match_array(gists)
    end

    it "user searches their gists by tag, they find public and private gists" do
      options = { profile: profile, tag: generic_tag_name }
      gists = [generic_public_gist_decorated, generic_private_gist_decorated]
      result = described_class.for(:gists, options).to_a
      expect(result).to match_array(gists)
    end

    it "user searches another user's gists by tag, public but private gists are found" do
      options = { profile: profile, tag: public_tag_name, private: false }
      gists = [public_gist_decorated]
      result = described_class.for(:gists, options).to_a
      expect(result).to match_array(gists)
    end
  end
end
