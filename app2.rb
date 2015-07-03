#app2

require 'sinatra/base'

require_relative 'helpers'
require_relative 'routes/secrets'
require_relative 'routes/sessions'

class SimpleApp < Sinatra::Base

  set :root, File.dirname(__FILE__)

  enable :sessions

  helpers Sinatra::SampleApp::Helpers

  register Sinatra::SampleApp::Routing::Sessions
  register Sinatra::SampleApp::Routing::Secrets

end

#helpers.rb

module Sinatra
  module SampleApp
    module Helpers

      def require_logged_in
        redirect('/sessions/new') unless is_authenticated?
      end

      def is_authenticated?
        return !!session[:user_id]
      end

    end
  end
end

#routes/secrets.rb

module Sinatra
  module SampleApp
    module Routing
      module Secrets

        def self.registered(app)
          show_secrets = lambda do
              require_logged_in
              erb :secrets
          end

          app.get '/secrets', &show_secrets
        end

      end
    end
  end
end

module Sinatra
  module SampleApp
    module Routing
      module Sessions

        def self.registered(app)
          show_login = lambda do
            erb :login
          end


          receive_login = lambda do
            session[:user_id] = params["user_id"]
            redirect '/secrets'
          end

          app.get '/', &show_login
          app.get '/sessions/new', &show_login
          app.post '/sessions', &receive_login
        end

      end
    end
  end
end
