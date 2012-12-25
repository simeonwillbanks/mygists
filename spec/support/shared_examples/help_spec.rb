shared_examples 'help' do
  it 'Tagging help' do
    get action
    page.should have_content('Include a tag in each gist description.')
  end
end
