###
# app.rb
#

require 'sinatra/base'

class SimpleApp < Sinatra::Base

  set :root, File.dirname(__FILE__)

  enable :sessions

  def require_logged_in
    redirect('/sessions/new') unless is_authenticated?
  end

  def is_authenticated?
    return !!session[:user_id]
  end

  show_login = lambda do
    erb: login
  end

  receive_login = lambda do
    session[:user_id] = params["user_id"]
    redirect '/secrets'
  end

  show_secrets = lambda do
    require_logged_in
    erb :secrets
  end

  get '/', &show_login
  get '/sessions/new', &show_login
  post '/sessions', &receive_login
  get '/secrets', &show_secrets
   
end
