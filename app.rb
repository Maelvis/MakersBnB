require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnb < Sinatra::Base
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
    @email = params[:email]
    @password = params[:password]
    @confirm_password = params[:confirm_password]
    erb :'/users/sign_up'
    redirect '/all-spaces'
  end

  get '/log-in' do
    erb :'/users/log_in'
  end

  post '/log-in' do
    @email = params[:email]
    @password = params[:password]
    erb :'/users/log_in'
    redirect '/my-spaces'
  end

  get '/all-spaces' do
    erb :'/spaces/all_spaces'
  end

  post '/book-space' do
    
  end

  get '/list-space' do
    
  end

  post '/list-space' do
    
  end

  get '/my-spaces' do
    
  end

  post '/booking-confirmation-requests' do
    
  end

  get '/booking-confirmation' do
    
  end


  run! if app_file == $0
end