require 'spec_helper'

describe ProfileDecorator do
  subject { FactoryGirl.build_stubbed(:profile).decorate }

  describe '#gravatar and #token' do
    context 'authenticated' do
      let(:gravatar) { 'image.png' }

      before(:each) do
        subject.should_receive(:h).twice.and_return(
          stub(
            user_signed_in?: true,
            session: {
              'warden.user.user.session' => {
                github: {
                  gravatar: gravatar
                }
              }
            }
          )
        )
      end

      its(:gravatar) { should eq(gravatar) }
    end

    context 'unauthenticated' do
      before(:each) do
        subject.should_receive(:h).once.and_return(
          stub(user_signed_in?: false)
        )
      end

      its(:gravatar) { should eq(ProfileDecorator::EMPTY_GRAVATAR) }
    end
  end

end
