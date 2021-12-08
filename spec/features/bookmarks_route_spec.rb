feature 'bookmarks page' do
  scenario 'viewing bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.google.com/');")
    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com/');")
    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.destroyallsoftware.com');")

    visit('/')
    expect(page).to have_content('http://www.google.com/')
    expect(page).to have_content('http://www.makersacademy.com/')
    expect(page).to have_content('http://www.destroyallsoftware.com')
  end
end