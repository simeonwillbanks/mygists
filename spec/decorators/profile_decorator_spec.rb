require 'spec_helper'

describe ProfileDecorator do
  subject { FactoryGirl.build_stubbed(:profile).decorate }

  describe '#gravatar and #token' do
    context 'authenticated' do
      let(:gravatar) { 'image.png' }
      let(:token) { '718a1ec03f404d5d35527cb953c99f521aee2700' }

      before(:each) do
        subject.should_receive(:h).twice.and_return(
          stub(
            user_signed_in?: true,
            session: {
              'warden.user.user.session' => {
                github: {
                  gravatar: gravatar,
                  token: token
                }
              }
            }
          )
        )
      end

      its(:gravatar) { should eq(gravatar) }
      its(:token) { should eq(token) }
    end

    context 'unauthenticated' do
      before(:each) do
        subject.should_receive(:h).once.and_return(
          stub(user_signed_in?: false)
        )
      end

      its(:gravatar) { should eq(ProfileDecorator::EMPTY_GRAVATAR) }
      its(:token) { should be_nil }
    end
  end

  context '#latest_gist_timestamp' do
    let(:updated_at) { DateTime.now }
    let(:timestamp) { updated_at.in_time_zone.strftime('%Y-%m-%dT%H:%M:%SZ') }

    context 'profile has gists' do
      before(:each) do
        subject.stub(:latest_gist).and_return(stub(updated_at: updated_at))
      end

      its(:latest_gist_timestamp) { should eq(timestamp) }
    end

    context 'profile has no gists' do
      before(:each) do
        subject.stub(:latest_gist).and_return(nil)
      end

      its(:latest_gist_timestamp) { should eq(nil) }
    end
  end
end
