require "spec_helper"

describe ApplicationHelper do
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

    context "help page" do
      it "should be Help | My Gists" do
        helper.page_title("Help").should eq("Help | My Gists")
      end
    end

    context "tags page" do
      it "should be tag | username | My Gists" do
        helper.page_title(%w(rails simeonwillbanks)).should eq("rails | simeonwillbanks | My Gists")
      end
    end
  end

  describe ".github" do
    subject { helper.github }
    its(:home_page) { should eq("https://github.com") }
    its(:gist_page) { should eq("https://gist.github.com") }
    its(:my_gists_page) { should eq("https://github.com/simeonwillbanks/mygists") }
    its(:simeon_page) { should eq("https://github.com/simeonwillbanks") }
  end
end
