require 'pg'
require_relative 'database_connection'

class Bookmark 
  
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
    
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    return result.map { |bookmark| 
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url']) 
    } # Return an array of bookmark objects
  end

  def self.add_bookmark(url:, title:)
      result = DatabaseConnection.query(
      "INSERT INTO bookmarks (url, title) VALUES ($1, $2) RETURNING id, title, url;",
      [url, title]
    ) # Add new bookmark data to database
    return Bookmark.new(id: result.first['id'], title: result.first['title'] , url: result.first['url']) # Return our new bookmark data in a Bookmark instance (more useful for testing)
  end

  def self.delete_bookmark(id:)
    return DatabaseConnection.query("DELETE FROM bookmarks WHERE id = $1", [id])
  end
  
end
