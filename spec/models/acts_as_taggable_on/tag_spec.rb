require 'spec_helper'

describe ActsAsTaggableOn::Tag do
  context 'class methods' do
    subject { described_class }
    its(:default) { should eq('Without Tags') }
  end

  context 'instance methods' do
    context 'default tag' do
      subject { FactoryGirl.create(:tag, name: 'Without Tags') }
      its(:default?) { should be_true }
      its(:slug) { should eq('without-tags') }
    end

    context 'tag other than default' do
      subject { FactoryGirl.create(:tag, name: 'rails') }
      its(:default?) { should be_false }
      its(:slug) { should eq('rails') }
    end
  end
end
