require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "exercise"
  end

  get '/' do
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'entries/list_page' 
    else
      erb :index
    end  
  end

 helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

    def logout!  
      session.clear
    end 

  end
end
