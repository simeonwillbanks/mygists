require "spec_helper"

describe MyGists::Fetch::StarStatus do
  context "only receives messages via class method" do
    it "sending a message to .new raises an exception" do
      expect { described_class.new }.to raise_exception(NoMethodError)
    end

    it "a message can be sent to .for" do
      described_class.should respond_to(:for)
    end
  end

  describe ".for" do
    let!(:gist) { FactoryGirl.build_stubbed(:gist) }
    let!(:client) { double("client") }

    before(:each) do
      Gist.stub(:find).and_return(gist)
      Octokit::Client.stub(:new).and_return(client)
    end

    after(:each) { described_class.for(gist.id) }

    context "gist is not starred" do

      it "update gist to no be starred" do
        client.should_receive(:gist_starred?).with(gist.gid).once.and_return(false)
        gist.should_receive(:update_column).with(:starred, false).once.and_return(true)
      end
    end

    context "gist is starred" do

      it "update gist to be starred" do
        client.should_receive(:gist_starred?).with(gist.gid).once.and_return(true)
        gist.should_receive(:update_column).with(:starred, true).once.and_return(true)
      end
    end
  end
end
