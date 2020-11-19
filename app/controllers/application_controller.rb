require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"

    get '/' do
      erb :welcome
    end

  end

  helpers do
    def is_logged_in
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end

    def authorized(recipe)
      recipe.user_id == session[:user_id]
    end

    def bullet_list(string)
    array=string.split("*")
    end

    def something_there(string)
     string.present?
    end


    def valid_bullets(string)
      string.include?("*")
    end


  end


end
