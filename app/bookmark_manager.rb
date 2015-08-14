require 'sinatra/base'
require_relative "../data_mapper_setup"
require_relative "./models/link"
require_relative "./models/user"
require 'sinatra/session'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  configure :development do
    set :bind, '0.0.0.0'
    set :port, 3000
  end

  enable :sessions
  register Sinatra::Flash


  set :session_secret, 'super secret'

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
    link = Link.new(url: params[:url], title: params[:title])
    (params[:tags].split).each do |tag| tag = Tag.first_or_create(name: tag)
    link.tags << tag
    end
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :index
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    elsif @user.email == ""
      flash.now[:notice] = "Email has not been entered"
      erb :'users/new'
    else @user.password == ""
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'users/new'
    end
  end

  helpers do
    def current_user
      User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
