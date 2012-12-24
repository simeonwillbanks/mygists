require 'spec_helper'

describe GistDecorator do
  describe '#url' do
    let(:gid) { '68c29f86f75b343953ef' }
    subject { FactoryGirl.build(:gist, gid: gid).decorate }
    its(:url) { should eq("https://gist.github.com/#{gid}") }
  end
end
