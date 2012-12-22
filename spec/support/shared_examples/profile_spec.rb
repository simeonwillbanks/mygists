shared_examples 'a profile' do
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

  it 'list items' do
    list_items.each do |li|
      get action, params
      page.should have_content(li)
    end
  end
end
