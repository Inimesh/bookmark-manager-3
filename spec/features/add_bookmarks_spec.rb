feature 'adds bookmarks' do
  scenario 'enter a web address and submit' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    visit('/')
    fill_in('new_bookmark', :with => 'www.google.com')
    click_on('Submit')

    expect(page).to have_content('www.google.com')
  end
end