shared_examples 'a profile' do
  context 'unauthenticated' do
    it 'redirects to root' do
      get action, params
      response.should redirect_to root_path
    end
  end

  context 'authenticated' do
    before(:each) { sign_in user }

    it 'returns http success' do
      get action, params
      response.should be_success
    end

    it 'has title' do
      get action, params
      page.should have_content(title)
    end

    it 'gravatar' do
      get action, params
      xpath = "//img[@alt='#{username}']"
      page.should have_selector(:xpath, xpath)
    end

    it 'profile menu item' do
      get action, params
      page.should have_link('Profile', count: 1)
    end

    it 'help menu item' do
      get action, params
      page.should have_link('Help', count: 1)
    end

    it 'sign out menu item' do
      get action, params
      page.should have_link('Sign Out', count: 1)
    end

    it 'list items' do
      list_items.each do |li|
        get action, params
        page.should have_content(li)
      end
    end
  end
end
