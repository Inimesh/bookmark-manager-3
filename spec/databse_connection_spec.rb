require 'database_connection'

describe DatabaseConnection do
  dbname_test = 'bookmark_manager_test'
  describe '.setup' do
    it 'sets up and returns a database connection object through PG module' do
      expect(PG).to receive(:connect).with(dbname: dbname_test)

      DatabaseConnection.setup('bookmark_manager_test')
    end

    it 'is a persistant connection' do
      connection = DatabaseConnection.setup(dbname_test)

      expect(DatabaseConnection.connection).to eq connection
    end
  end

  describe '.query' do
    it 'executes a query via PG' do
      connection = DatabaseConnection.setup(dbname_test)

      expect(connection).to receive(:exec_params).with("SELECT * FROM bookmarks;", [])

      DatabaseConnection.query("SELECT * FROM bookmarks;")
    end
  end
  
end