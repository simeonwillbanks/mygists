require 'spec_helper'

describe ProfileDecorator do
  subject { FactoryGirl.build_stubbed(:profile).decorate }

  describe '#gravatar and #token' do
    context 'authenticated' do
      let(:gravatar) { 'image.png' }
      let(:token) { '818a1ec03f404d5d35527cb953c99f521aee2700' }

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

end
