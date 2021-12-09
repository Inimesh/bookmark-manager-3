require 'pg'

class Bookmark 
  
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
    
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    
    result = connection.exec("SELECT * FROM bookmarks;") # Retrieve all bookmark data from database
    return result.map { |bookmark| 
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url']) 
    } # Return an array of bookmark objects
  end

  def self.add_bookmark(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, title, url;") # Add new bookmark data to database
    return Bookmark.new(id: result.first['id'], title: result.first['title'] , url: result.first['url']) # Return our new bookmark data in a Bookmark instance (more useful for testing)
  end
end
