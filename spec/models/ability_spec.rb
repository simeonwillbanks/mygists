require 'spec_helper'

describe Ability do
  subject { ability }
  let(:ability) { Ability.new(user) }
  let(:user) { nil }

  context 'user views their profile' do
    let(:user) { FactoryGirl.create(:user) }
    it { should be_able_to(:read, user.profile) }
  end

  context 'user views another users profile' do
    let(:user) { FactoryGirl.create(:user) }
    let(:another_user) { FactoryGirl.create(:user) }
    it { should_not be_able_to(:read, another_user.profile) }
  end
end
