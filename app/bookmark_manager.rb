require 'sinatra/base'
require_relative "../data_mapper_setup"
require_relative "./models/link"

class BookmarkManager < Sinatra::Base
  configure :development do
    set :bind, '0.0.0.0'
    set :port, 3000
  end

  get '/' do
    erb :start
  end

  get '/links' do
    @links = Link.all
    erb :index
  end

  get '/links/new' do
    erb :create_links
  end

  post '/links' do
    split_tag = []
    split_tag = params[:tag].split
    link = Link.new(url: params[:url],     # 1. Create a link
                  title: params[:title])
    tag  = Tag.create(name: split_tag[0])
    tag2  = Tag.create(name: split_tag[1]) # 2. Create a tag for the link

    link.tags << tag          # 3. Adding the tag to the link's DataMapper collection.
    # link.save                              # 4. Saving the link.
    link.tags << tag2          # 3. Adding the tag to the link's DataMapper collection.
    link.save                              # 4. Saving the link.
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
