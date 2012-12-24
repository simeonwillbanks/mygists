require 'spec_helper'

describe ProfileDecorator do
  describe '#gravatar' do
    context 'gravatar exists' do
      let(:gravatar) { 'image.png' }
      subject { FactoryGirl.build(:profile, gravatar: gravatar).decorate }
      its(:gravatar) { should eq(gravatar) }
    end

    context 'gravatar does not exist' do
      subject { FactoryGirl.build(:profile).decorate }
      its(:gravatar) { should eq(ProfileDecorator::EMPTY_GRAVATAR) }
    end
  end
end
