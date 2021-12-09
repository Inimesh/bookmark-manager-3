feature 'adds bookmarks' do
  scenario 'user can add a bookmark' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    visit('/')
    fill_in('url', with: 'www.google.com')
    fill_in('title', with: 'Google' )
    click_on('Submit')

    expect(page).to have_link('Google', href: 'www.google.com')
  end
end