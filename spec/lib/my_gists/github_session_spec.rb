require "spec_helper"

describe MyGists::GitHubSession do
  let!(:user) { FactoryGirl.build_stubbed(:user) }
  let!(:auth) { OpenStruct.new(session: {}) }

  context "Warden has set a user and optional github metdata is set" do
    let!(:opts) { {github: {gravatar: "user.jpg"}} }
    subject { described_class.set_auth(user, auth, opts) }
    it "adds github metadata to session" do
      subject.session[:github].should eq(opts[:github])
    end
  end

  context "Warden has not set a user" do
    let!(:opts) { Hash.new }
    subject { described_class.set_auth(user, auth, opts) }
    it "github metadata is not added to session" do
      subject.session[:github].should be_nil
    end
  end
end
