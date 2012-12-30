require 'spec_helper'

describe MyGists::Fetch do
  context 'only receives messages via class method' do
    it 'sending a message to .new raises an exception' do
      expect { described_class.new }.to raise_exception(NoMethodError)
    end

    it 'a message can be sent to .for' do
      described_class.should respond_to(:for)
    end
  end

  describe '.for' do
    let(:options) { {username: 'simeonwillbanks', token: '718a1ec03f404d5d35527cb953c99f521aee2700' } }
    let(:gists) do
      [stub(description: 'gist 1', :[] => 1, :[]= => nil),
       stub(description: 'gist 2', :[] => 2, :[]= => nil)]
    end
    let(:client) { double(gists: gists, gist_starred?: true) }

    before(:each) do
      Octokit::Client.stub(:new).and_return(client)
    end

    it 'returns an array of gists' do
      described_class.for(options).should eq(gists)
    end

    it 'fetching gists can be done with optional timestamp' do
      options.merge!(since: DateTime.now.in_time_zone.strftime('%Y-%m-%dT%H:%M:%SZ'))
      client.should_receive(:gists).with(options[:username], options)
      described_class.for(options).should eq(gists)
    end
  end
end
