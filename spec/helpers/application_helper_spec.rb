require 'spec_helper'

describe ApplicationHelper do
  describe '.page_title' do
    context 'home page' do
      it 'should be My Gists' do
        helper.page_title.should eq('My Gists')
      end
    end

    context 'profile page' do
      it 'should be username | My Gists' do
        helper.page_title('simeonwillbanks').should eq('simeonwillbanks | My Gists')
      end
    end

    context 'help page' do
      it 'should be Help | My Gists' do
        helper.page_title('Help').should eq('Help | My Gists')
      end
    end

    context 'tags page' do
      it 'should be tag | username | My Gists' do
        helper.page_title(['rails', 'simeonwillbanks']).should eq('rails | simeonwillbanks | My Gists')
      end
    end

  end
end
