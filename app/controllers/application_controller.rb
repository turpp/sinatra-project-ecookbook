require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "n.BZxhtxUA,A.e9U"
  end

    get '/' do
      erb :welcome
    end

  helpers do
    def is_logged_in
      !!session[:user_id]
    end

    def authorized(recipe)
      recipe.user_id == session[:user_id]
    end

    def bullet_list(string)
    array=string.split("*").reject{|i| i==""}
    
    end

    def something_there_recipes
      valid=params[:recipe].map do |k,v|
        v.present?
      end
      !valid.include?(false) && valid.count==6
    end

    def something_there_users
      username=params[:user][:username].present?
      pass=params[:user][:password].present?
      username&&pass
    end



    def valid_bullets
      ingredients= params[:recipe][:ingredients].include?("*")
      steps= params[:recipe][:steps].include?("*")
      ingredients&&steps
      end

  end

end
