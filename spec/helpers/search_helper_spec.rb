require "spec_helper"

describe SearchHelper do
  let(:profile) { "simeonwillbanks" }
  let(:tag) { "rails" }

  let(:params_full) { { profile: profile, tag: tag } }

  let(:params_with_profile) { { profile: profile, tag: "" } }
  let(:params_with_tag) { { profile: "", tag: tag } }

  let(:params_empty) { { profile: "", tag: "" } }
  let(:params_nil) { { } }

  let(:profile_link) { "<a href=\"/#{profile}\">#{profile}</a>" }
  let(:hash_tag) { "##{tag}" }

  context "user visits search page by clicking 'Search' in the navigation" do
    before(:each) { helper.stub(:params).and_return(params_nil) }

    describe ".profile_search_term" do
      subject { helper.profile_search_term }
      it { should be_nil }
    end

    describe ".tag_search_term" do
      subject { helper.tag_search_term }
      it { should be_nil }
    end

    describe ".search?" do
      subject { helper.search? }
      it { should be_false }
    end

    describe ".profile_search?" do
      subject { helper.profile_search? }
      it { should be_false }
    end

    describe ".tag_search?" do
      subject { helper.tag_search? }
      it { should be_false }
    end
  end

  context "user performs a search without entering a tag or profile" do
    before(:each) { helper.stub(:params).and_return(params_empty) }

    describe ".profile_search_term" do
      subject { helper.profile_search_term }
      it { should be_empty }
    end

    describe ".tag_search_term" do
      subject { helper.tag_search_term }
      it { should be_empty }
    end

    describe ".search?" do
      subject { helper.search? }
      it { should be_true }
    end

    describe ".profile_search?" do
      subject { helper.profile_search? }
      it { should be_false }
    end

    describe ".tag_search?" do
      subject { helper.tag_search? }
      it { should be_false }
    end
  end

  context "user performs a search by entering a tag" do
    before(:each) { helper.stub(:params).and_return(params_with_tag) }

    describe ".profile_search_term" do
      subject { helper.profile_search_term }
      it { should be_empty }
    end

    describe ".tag_search_term" do
      subject { helper.tag_search_term }
      it { should eq(tag) }
    end

    describe ".search?" do
      subject { helper.search? }
      it { should be_true }
    end

    describe ".profile_search?" do
      subject { helper.profile_search? }
      it { should be_false }
    end

    describe ".tag_search?" do
      subject { helper.tag_search? }
      it { should be_true }
    end

    describe ".search_hash_tag" do
      subject { helper.search_hash_tag }
      it { should eq(hash_tag) }
    end
  end

  context "user performs a search by entering a profile" do
    before(:each) { helper.stub(:params).and_return(params_with_profile) }

    describe ".profile_search_term" do
      subject { helper.profile_search_term }
      it { should eq(profile) }
    end

    describe ".tag_search_term" do
      subject { helper.tag_search_term }
      it { should be_empty }
    end

    describe ".search?" do
      subject { helper.search? }
      it { should be_true }
    end

    describe ".profile_search?" do
      subject { helper.profile_search? }
      it { should be_true }
    end

    describe ".tag_search?" do
      subject { helper.tag_search? }
      it { should be_false }
    end

    describe ".search_profile_link" do
      subject { helper.search_profile_link }
      it { should eq(profile_link) }
    end
  end

  context "user performs a search by entering a profile and tag" do
    before(:each) { helper.stub(:params).and_return(params_full) }

    describe ".profile_search_term" do
      subject { helper.profile_search_term }
      it { should eq(profile) }
    end

    describe ".tag_search_term" do
      subject { helper.tag_search_term }
      it { should eq(tag) }
    end

    describe ".search?" do
      subject { helper.search? }
      it { should be_true }
    end

    describe ".profile_search?" do
      subject { helper.profile_search? }
      it { should be_true }
    end

    describe ".tag_search?" do
      subject { helper.tag_search? }
      it { should be_true }
    end

    describe ".search_hash_tag" do
      subject { helper.search_hash_tag }
      it { should eq(hash_tag) }
    end

    describe ".search_profile_link" do
      subject { helper.search_profile_link }
      it { should eq(profile_link) }
    end
  end
end
