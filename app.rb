require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @all_bookmarks = Bookmark.all
    erb :index
  end

  post '/add-bookmark' do
    Bookmark.add_bookmark(params[:new_bookmark])
    redirect '/'
  end

  run! if app_file == $0
end