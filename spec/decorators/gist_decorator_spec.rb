require 'spec_helper'

describe GistDecorator do
  describe '#url' do
    let(:gid) { '68c29f86f75b343953ef' }
    subject { FactoryGirl.build(:gist, gid: gid).decorate }
    its(:url) { should eq("https://gist.github.com/#{gid}") }
  end

  describe '#description' do
    context 'gist has a description' do
      let(:description) { 'Tag: Look at this gist' }
      subject { FactoryGirl.build(:gist, description: description).decorate }
      its(:description) { should eq(description) }
    end

    context 'gist has no description' do
      subject { FactoryGirl.build(:gist, description: nil).decorate }
      its(:description) { should eq(GistDecorator::DEFAULT_DESCRIPTION) }
    end
  end
end
