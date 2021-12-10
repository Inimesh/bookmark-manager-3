require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end
  
  enable :sessions, :method_override
  
  get '/' do
    'Bookmark Manager'
  end
  
  get '/bookmarks' do 
    @all_bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end
  
  post '/bookmarks' do
    Bookmark.add_bookmark(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end
  
  delete '/bookmarks/:id' do
    Bookmark.delete_bookmark(id: params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end