require "spec_helper"

describe ApplicationHelper do
  describe ".navigation_item_matches_request?" do
    let(:user) { FactoryGirl.build_stubbed(:user) }

    context "current user visits their profile" do
      it "should be true" do
        helper.stub(:current_user).and_return(user)
        helper.stub(:params).and_return({ username: user.profile.username })
        helper.navigation_item_matches_request?(:my_profile).should be_true
      end
    end

    context "current user visits another users profile" do
      it "should be false" do
        helper.stub(:current_user).and_return(user)
        helper.stub(:params).and_return({ username: "another" })
        helper.navigation_item_matches_request?(:my_profile).should be_false
      end
    end

    context "any user visits the help page" do
      it "should be true" do
        helper.stub(:controller_name).and_return("help")
        helper.navigation_item_matches_request?(:help).should be_true
      end
    end
  end

  describe ".render_fetching_info?" do
    context "omniauth callback is referrer" do
      it "should be true" do
        helper.stub(:flash).and_return(from_omniauth_callback: true)
        helper.render_fetching_info?.should be_true
      end
    end

    context "omniauth callback is not referrer" do
      it "should be false" do
        helper.stub(:flash).and_return({})
        helper.render_fetching_info?.should be_false
      end
    end
  end

  describe ".page_title" do
    context "home page" do
      it "should be My Gists" do
        helper.page_title.should eq("My Gists")
      end
    end

    context "profile page" do
      it "should be username | My Gists" do
        helper.page_title("simeonwillbanks").should eq("simeonwillbanks | My Gists")
      end
    end

    context "search page" do
      it "should be search | My Gists" do
        helper.page_title("Search").should eq("Search | My Gists")
      end
    end

    context "help page" do
      it "should be Help | My Gists" do
        helper.page_title("Help").should eq("Help | My Gists")
      end
    end

    context "profile tags page" do
      it "should be tag | username | My Gists" do
        helper.page_title("rails", "simeonwillbanks").should eq("rails | simeonwillbanks | My Gists")
      end
    end

    context "tags page" do
      it "should be Tags | My Gists" do
        helper.page_title(*["Tags"]).should eq("Tags | My Gists")
      end
    end

    context "tags show page" do
      it "should be tag | Tags | My Gists" do
        helper.page_title(*["tag", "Tags"]).should eq("tag | Tags | My Gists")
      end
    end
  end

  describe ".github" do
    subject(:github) { helper.github }

    it { github.home_page.should eq("https://github.com") }
    it { github.gist_page.should eq("https://gist.github.com") }
    it { github.my_gists_page.should eq("https://github.com/simeonwillbanks/mygists") }
    it { github.simeon_page.should eq("https://github.com/simeonwillbanks") }
    it { github.profile_page("simeonwillbanks").should eq("https://github.com/simeonwillbanks") }
  end

  describe ".hashtag_to_slug" do
    subject(:hashtag_to_slug) { helper.hashtag_to_slug("#Rails") }

    context "slug is found" do
      let(:slug) { "rails" }

      before(:each) { MyGists::Cache::Tags::Helper.stub(:slug_from_hashtag).and_return(slug) }

      it { should eq(slug) }
    end

    context "slug is not found" do

      before(:each) { MyGists::Cache::Tags::Helper.stub(:slug_from_hashtag).and_return(nil) }

      it { should be_nil }
    end
  end

  describe ".tag_path" do
    subject(:tag_path) { helper.tag_path(slug: "rails") }

    it { should eq("/tags/rails") }

    context "within a profile request" do
      let(:profile) { FactoryGirl.build_stubbed(:user).profile }

      it "builds a path to the profiles tags" do
        helper.should_receive(:profile?).and_return(true)
        helper.should_receive(:profile).and_return(profile)

        tag_path.should eq("/simeonwillbanks/tags/rails")
      end
    end
  end
end
