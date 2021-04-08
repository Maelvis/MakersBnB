require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/space'
require './lib/user'
require './lib/database_connection_setup.rb'
require './lib/database_connection.rb'

class MakersBnb < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end
  
  get '/sign-up' do
    erb :'/users/sign_up'
  end

  post '/sign-up' do
    if User.registered?(email: params[:email])
      flash[:notice] = "Credentials have already been used by another user."
      redirect '/sign-up'
    else
      user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect '/list-space'
    end
  end

  get '/log-in' do
    erb :'/users/log_in'
  end

  post '/log-in' do
    user = User.authenticate(email: params[:email], password: params[:password])

    if user
      session[:user_id] = user.id
      redirect('/my-spaces')
    else
      flash[:notice] = 'Please check your email or password.'
      redirect('/log-in')
    end
  end

  get '/all-spaces' do
    @spaces = Space.view_all_spaces
    erb :'/spaces/all_spaces'
  end


  post '/list-space' do
    Space.create_space(name: params[:name], description: params[:description], price: params[:price], host_id: session[:user_id])
    redirect '/all-spaces'
  end

  get '/list-space' do
    erb :'/spaces/list_spaces'
  end

  get '/my-spaces' do
    p session[:user_id]
    @spaces = Space.view_my_spaces(host_id: session[:user_id])
    erb :'/spaces/my_spaces'
  end


  run! if app_file == $0
end