require "spec_helper"

describe MyGists::Cache do
  let(:username) { "simeonwillbanks" }
  let(:username_array) { [username] }
  let(:key) { :profiles }

  describe ".read" do
    it "fetches data from the cache, using the given key" do
      Profile.stub(:usernames).and_return(username_array)
      described_class.read(key).should match_array(username_array)
    end
  end

  describe ".write" do
    it "writes the value to the cache, with the key" do
      described_class.stub(:source).and_return(username_array)
      Rails.cache.should_receive(:write).with(key, username_array, expires_in: 15.minutes).once
      described_class.write(key)
    end

    it "raises an expection when the cache can not be written for given key" do
      expect { described_class.write(:bad) }.to raise_error(MyGists::Cache::InvalidCacheKey)
    end
  end
end
