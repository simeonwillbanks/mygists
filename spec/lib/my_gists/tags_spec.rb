require 'spec_helper'

describe MyGists::Tags do
  context 'only receives messages via class method' do
    it 'sending a message to .new raises an exception' do
      expect { described_class.new }.to raise_exception(NoMethodError)
    end

    it 'a message can be sent to .for' do
      described_class.should respond_to(:for)
    end
  end

  describe '.for' do
    let(:gist_with_tag) { FactoryGirl.build_stubbed(:gist, description: '#RailsTemplate Devise-OmniAuth-CanCan') }
    let(:gist_with_tags) { FactoryGirl.build_stubbed(:gist, description: '#RailsTemplate Devise-OmniAuth-CanCan #rails') }
    let(:gist_without_tag) { FactoryGirl.build_stubbed(:gist, description: 'Devise-OmniAuth-CanCan') }
    let(:tag) { ['RailsTemplate'] }
    let(:tags) { ['RailsTemplate', 'rails'] }
    let(:uncategorized) { ['Uncategorized'] }

    context 'description has a tag' do
      it 'returns found tag' do
        described_class.for(gist_with_tag).should eq(tag)
      end
    end

    context 'description has many tags' do
      it 'returns found tags' do
        described_class.for(gist_with_tags).should eq(tags)
      end
    end

    context 'description does not have a tag' do
      it 'returns "uncategorized" tag' do
        described_class.for(gist_without_tag).should eq(uncategorized)
      end
    end

    context 'description is nil' do
      it 'returns "uncategorized" tag' do
        described_class.for(gist_without_tag).should eq(uncategorized)
      end
    end
  end
end
