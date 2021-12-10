feature 'removing bookmarks' do
  scenario 'the user can delete a specified bookmark' do
    Bookmark.add_bookmark(url: 'https://www.example.com', title: 'Example')
    Bookmark.add_bookmark(url: 'https://www.anotherexample.com', title: 'Another Example')
    visit('/bookmarks')
    expect(page).to have_link('Example', href: 'https://www.example.com')
    expect(page).to have_link('Another Example', href: 'https://www.anotherexample.com')

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'

    expect(page).not_to have_link('Example', href: 'https://www.example.com')
    expect(page).to have_link('Another Example', href: 'https://www.anotherexample.com')

  end
end