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

    result = connection.exec_params(
      # First argument is an SQL query template
      # Second argument is the 'params'
      # $1 refers to the first item in the params array
      # $2 refers to the second item in the params array
      "INSERT INTO bookmarks (url, title) VALUES ($1, $2) RETURNING id, title, url;",
      [url, title]
    ) # Add new bookmark data to database
    return Bookmark.new(id: result.first['id'], title: result.first['title'] , url: result.first['url']) # Return our new bookmark data in a Bookmark instance (more useful for testing)
  end

  def self.delete_bookmark(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    connection.exec_params("DELETE FROM bookmarks WHERE id = $1", [id])
  end
  
end
