require 'spec_helper'

describe Gist do
  it { should validate_presence_of(:gid) }
  it { should belong_to(:profile) }
  its(:starred?) { should be_false }

  context 'starred' do
    subject { FactoryGirl.build(:gist, starred: true) }
    its(:starred?) { should be_true }
  end

  context 'public' do
    subject { FactoryGirl.build(:gist, public: true) }
    its(:public?) { should be_true }
  end

  context 'private' do
    subject { FactoryGirl.build(:gist, public: false) }
    its(:public?) { should be_false }
  end
end
