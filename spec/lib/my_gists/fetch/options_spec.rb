require 'spec_helper'

describe MyGists::Fetch::Options do

  describe '.to_hash' do
    let(:timestamp) { DateTime.now.in_time_zone.strftime('%Y-%m-%dT%H:%M:%SZ') }
    let(:profile) do
      double(username: 'simeonwillbanks', token: '818a1ec03f404d5d35527cb953c99f521aee2700')
    end

    context 'profile gists can be filtered by timestamp' do
      it 'returns a hash with a timestamp' do
        described_class.any_instance.tap do |klass|
          klass.should_receive(:filterable?).and_return(true)
          klass.should_receive(:timestamp).and_return(timestamp)
        end
        options = {
          username: profile.username,
          token: profile.token,
          since: timestamp
        }
        described_class.hash(profile).should eq(options)
      end
    end

    context 'profile gists can not be filtered by timestamp' do
      it 'returns a hash without a timestamp' do
        described_class.any_instance.should_receive(:filterable?).and_return(false)
        options = {
          username: profile.username,
          token: profile.token,
          since: nil
        }
        described_class.hash(profile).should eq(options)
      end
    end
  end
end
