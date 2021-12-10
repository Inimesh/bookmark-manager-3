require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  p 'Setting up test database...'
  DatabaseConnection.setup('bookmark_manager_test')
else
  DatabaseConnection.setup('bookmark_manager')
end