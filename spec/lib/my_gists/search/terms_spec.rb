require "spec_helper"

describe MyGists::Search::Terms do
  subject(:terms) { described_class }

  context "all possible tag search terms" do
    let(:tags) { ["Rails", "TDD"] }

    let(:tags_hash) do
      {
        "rails" => { name: "Rails", slug: "rails", public: true },
        "tdd"   => { name: "TDD", slug: "tdd", public: true }
      }
    end

    it "gets the terms from the cache" do
      MyGists::Cache.should_receive(:read).with(:tags).and_return(tags_hash)
      terms.tags.should match_array(tags)
    end
  end

  context "all possible profile search terms" do
    let(:profiles) { ["simeonwillbanks"] }

    it "gets the terms from the cache" do
      MyGists::Cache.should_receive(:read).with(:profiles).and_return(profiles)
      terms.profiles.should match_array(profiles)
    end
  end
end
