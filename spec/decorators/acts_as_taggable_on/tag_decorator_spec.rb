require 'spec_helper'

describe ActsAsTaggableOn::TagDecorator do
  describe '#name' do
    subject { FactoryGirl.build(:tag, name: 'rails').decorate }
    its(:name) { should eq('#rails') }
    its(:to_s) { should eq('#rails') }
  end
end
