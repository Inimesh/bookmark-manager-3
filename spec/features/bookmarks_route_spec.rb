feature 'bookmarks page' do
  scenario 'viewing bookmarks' do

    Bookmark.add_bookmark('http://www.google.com/')
    Bookmark.add_bookmark('http://www.makersacademy.com/')
    Bookmark.add_bookmark('http://www.destroyallsoftware.com')

    visit('/')
    expect(page).to have_content('http://www.google.com/')
    expect(page).to have_content('http://www.makersacademy.com/')
    expect(page).to have_content('http://www.destroyallsoftware.com')
  end
end