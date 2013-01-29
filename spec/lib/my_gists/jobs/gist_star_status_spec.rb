require "spec_helper"

describe MyGists::Jobs::GistStarStatus do

  let(:gist_id) { 1 }

  context ".perform" do

    it "should use star status fetcher" do
      MyGists::Fetch::StarStatus.should_receive(:for).with(gist_id)

      described_class.perform(gist_id)
    end
  end
end
