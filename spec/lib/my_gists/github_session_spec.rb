require "spec_helper"

describe MyGists::GitHubSession do
  let(:auth) { OpenStruct.new(session: {}) }

  let(:github_session) do
    described_class.set_auth(user, auth, opts).session[:github]
  end

  subject { github_session }

  context "Warden has set a user and optional github metdata is set" do
    let(:user) { FactoryGirl.build_stubbed(:user) }
    let(:opts) { { github: { gravatar: "user.jpg" } } }
    it { should eq(opts[:github]) }
  end

  context "Warden has not set a user" do
    let(:user) { {} }
    let(:opts) { {} }
    it { should be_nil }
  end
end
