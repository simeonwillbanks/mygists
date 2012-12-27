require 'spec_helper'

describe MyGists::Refresh do
  context 'only receives messages via class method' do
    it 'sending a message to .new raises an exception' do
      expect { described_class.new }.to raise_exception(NoMethodError)
    end

    it 'a message can be sent to .for' do
      described_class.should respond_to(:for)
    end
  end

  describe '.for' do
    let(:profile) { FactoryGirl.create(:user).profile.decorate }
    let(:tag) { '#ProTip' }

    let(:new_gid) { rand(0..1000).to_s }
    let(:old_gid) { rand(0..1000).to_s }

    let(:new_description) { "#{tag} High Speed Rails Idioms" }
    let(:old_description) { "#{tag} Tap That Object" }

    let(:old_gist) { FactoryGirl.create(:gist, description: old_description, gid: old_gid, profile: profile) }

    let(:new_gists) do
      [{
        'description' => new_description,
        'updated_at' => '2011-06-04T20:35:47Z',
        'created_at' => '2011-06-04T20:35:47Z',
        'id' => new_gid
      }]
    end
    let(:old_gists) do
      [{
        'description' => old_gist.description,
        'updated_at' => old_gist.updated_at,
        'created_at' => old_gist.created_at,
        'id' => old_gid
      }]
    end

    context 'profile has no gists' do
      before(:each) do
        described_class.any_instance.stub(:gists).and_return(new_gists)
      end

      it 'creates a gist for profile' do
        expect do
          described_class.for(profile)
        end.to change(Gist, :count).by(1)
      end

      it 'tags the profile from gist description' do
        described_class.for(profile)
        profile.owned_tags.length.should eq(1)
        profile.owned_tags.first.name.should eq(tag)
      end
    end

    context 'profile has gists' do
      before(:each) do
        described_class.any_instance.stub(:gists).and_return(old_gists)
      end

      it 'updates the gist' do
        expect do
          described_class.for(profile)
        end.to change(Gist, :count).by(0)
      end

      it 'profile tags stay the same' do
        described_class.for(profile)
        profile.owned_tags.length.should eq(1)
        profile.owned_tags.first.name.should eq(tag)
      end
    end
  end
end
