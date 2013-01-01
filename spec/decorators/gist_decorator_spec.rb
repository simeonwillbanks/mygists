require 'spec_helper'

describe GistDecorator do
  describe '#icons' do
    context 'gist is starred and public' do
      subject { FactoryGirl.build(:gist, starred: true, public: true).decorate }
      its(:icons) { should eq('<i class="icon-star"></i><i class="icon-ok-sign"></i>') }
    end

    context 'gist is starred and private' do
      subject { FactoryGirl.build(:gist, starred: true, public: false).decorate }
      its(:icons) { should eq('<i class="icon-star"></i><i class="icon-lock"></i>') }
    end

    context 'gist is not starred and public' do
      subject { FactoryGirl.build(:gist, starred: false, public: true).decorate }
      its(:icons) { should eq('<i class="icon-ok-sign"></i>') }
    end

    context 'gist is not starred and private' do
      subject { FactoryGirl.build(:gist, starred: false, public: false).decorate }
      its(:icons) { should eq('<i class="icon-lock"></i>') }
    end
  end

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
