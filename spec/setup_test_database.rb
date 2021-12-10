def cleanup_test_database
  require 'pg'

  p "Cleaning up test database..."

  connection = PG.connect(dbname: 'bookmark_manager_test')

  connection.exec("TRUNCATE bookmarks RESTART IDENTITY;")
end