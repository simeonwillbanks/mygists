require 'spec_helper'

describe Profile do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }
  it { should have_many(:gists) }

  context 'custom param key' do
    subject { FactoryGirl.build_stubbed(:profile) }
    its(:to_param) { should eq('simeonwillbanks') }
  end
end
