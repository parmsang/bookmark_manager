require 'sinatra/base'
require_relative "../data_mapper_setup"
require_relative "./models/link"

class BookmarkManager < Sinatra::Base
  configure :development do
    set :bind, '0.0.0.0'
    set :port, 3000
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end