shared_examples "a profile" do
  context "unauthenticated" do
    before(:each) { get action, params }

    it "profile page should render" do
      response.should be_success
    end

    it "home menu item" do
      page.should have_link("Home", count: 1)
    end

    it "search menu item" do
      page.should have_link("Search", count: 1)
    end

    it "help menu item" do
      page.should have_link("Help", count: 1)
    end

    it "sign in menu item" do
      page.should have_link("Sign In", count: 1)
    end
  end

  context "authenticated" do
    before(:each) do
      sign_in user
      get action, params
    end

    it "returns http success" do
      response.should be_success
    end

    it "has title" do
      page.should have_content(title)
    end

    it "gravatar" do
      xpath = "//img[@alt='#{username}']"
      page.should have_selector(:xpath, xpath)
    end

    it "profile menu item" do
      page.should have_link("My Profile", count: 1)
    end

    it "search menu item" do
      page.should have_link("Search", count: 1)
    end

    it "help menu item" do
      page.should have_link("Help", count: 1)
    end

    it "sign out menu item" do
      page.should have_link("Sign Out", count: 1)
    end
  end
end
