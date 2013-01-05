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

  context 'decrypted token' do
    let(:token) { MyGists::Secure.encrypt('token') }
    subject { FactoryGirl.build_stubbed(:profile, token: token) }
    its(:token) { should eq('token') }
  end
end
