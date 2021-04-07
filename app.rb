require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/sign-up' do
    erb :'/users/sign_up'
  end

  post '/sign-up' do
    @email = params[:email]
    @password = params[:password]
    @confirm_password = params[:confirm_password]
    erb :'/users/sign_up'
  end

  get '/log-in' do
    erb :'/users/log_in'
  end

  post '/log-in' do
    @email = params[:email]
    @password = params[:password]
    erb :'/users/log_in'
  end

  

  run! if app_file == $0
end