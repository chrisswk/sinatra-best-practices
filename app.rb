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

  get '/' do
    erb :login
  end

  get '/sessions/new' do
    erb :login
  end

  post '/sessions' do
    session[:user_id] = params["user_id"]
    #redirect('/secrets')
  end

  get '/secrets' do
    require_logged_in
    erb :secrets
  end
  
end
