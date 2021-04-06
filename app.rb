require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World, I am testing branches!'
  end

  run! if app_file == $0
end