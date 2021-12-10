require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'should return a list of the bookmark instances' do
      # connection = PG.connect(dbname: 'bookmark_manager_test')
      bookmark = Bookmark.add_bookmark(url: 'http://www.makersacademy.com/', title: 'Makers Academy')
      Bookmark.add_bookmark(url: 'http://www.google.com/', title: 'google')
      Bookmark.add_bookmark(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
      
      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com/'
    end
  end

  describe '.add_bookmark' do
    it 'should add a new bookmark to the database and return a bookmark instance' do

      bookmark = Bookmark.add_bookmark(url: 'www.google.com', title: 'Google')
      persisted_data = persisted_data(id: bookmark.id)
      
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Google'
      expect(bookmark.url).to eq 'www.google.com'

    end
  end

  describe '.delete_bookmark' do
    it 'deletes the specified bookmark' do
      bookmark = Bookmark.add_bookmark(title: 'Example', url: 'https://www.example.com')

      Bookmark.delete_bookmark(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end
end 