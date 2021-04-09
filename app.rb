require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/space'
require './lib/user'
require './lib/booking'
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
    redirect '/my-spaces'
  end

  get '/list-space' do
    flash[:notice] = 'You need to be logged in to list a space.' unless session[:user_id]
    redirect '/' unless session[:user_id]
    erb :'/spaces/list_spaces'
  end

  get '/my-spaces' do
    flash[:notice] = 'You need to be logged in.' unless session[:user_id]
    redirect '/' unless session[:user_id]
    @spaces = Space.view_my_spaces(host_id: session[:user_id])
    erb :'/spaces/my_spaces'
  end


  post '/booking' do
    space_id = DatabaseConnection.query("SELECT id FROM spaces WHERE name = '#{params[:space]}'")[0]['id']
    host_id = DatabaseConnection.query("SELECT host_id FROM spaces WHERE name = '#{params[:space]}'")[0]['host_id']
    Booking.create(space_id: space_id, guest_id: session[:user_id], host_id: host_id, start_date: params[:start_date], leave_date: params[:leave_date])
    redirect '/'
  end

  get '/my-requested-spaces' do
    flash[:notice] = 'You need to be logged in.' unless session[:user_id]
    p @spaces = Space.view_booking_requests(host_id: session[:user_id])
    erb :'/spaces/my_requested_spaces'
  end

  post '/confirm' do
    if params[:approve] != nil
      p params[:name]
      p space_id = DatabaseConnection.query("SELECT id FROM spaces WHERE name = '#{params[:name]}'")[0]['id']
      p booking_id = DatabaseConnection.query("SELECT id FROM bookings WHERE space_id = '#{space_id}'")[0]['id']
      Booking.confirm(booking_id: booking_id)
      redirect '/'
    end
  end

  post '/sign-out' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect('/')
  end


  run! if app_file == $0
end