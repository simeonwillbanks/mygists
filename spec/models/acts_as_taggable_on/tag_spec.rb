require 'spec_helper'

describe ActsAsTaggableOn::Tag do
  context 'class methods' do
    subject { described_class }
    its(:default) { should eq('Without Tags') }
  end

  context 'instance methods' do
    context 'default tag' do
      subject { FactoryGirl.build(:tag, name: 'Without Tags') }
      its(:default?) { should be_true }
    end

    context 'default tag' do
      subject { FactoryGirl.build(:tag, name: 'rails') }
      its(:default?) { should be_false }
    end
  end
end
