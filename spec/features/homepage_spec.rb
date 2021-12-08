feature 'testing homepage' do
  scenario 'user can see that it is the title page' do
    visit('/')
    expect(page).to have_content 'Bookmark Manager'
  end
end