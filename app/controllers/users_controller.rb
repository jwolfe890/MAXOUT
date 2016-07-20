class UsersController < ApplicationController

  get '/signup' do
    if !is_logged_in?
      erb :'users/create_user'
    else 
      redirect "/"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else 
      @user = User.new(:username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/'
  end  
  end

  get '/login' do 
    if is_logged_in?
      redirect '/'
    else 
      erb :'users/login'
    end
  end 

  post '/login' do
    if user = User.find_by(:username => params["username"])
      if user.authenticate(params["password"])
        session[:user_id] = user.id
        redirect '/'
      else 
        redirect '/signup'
      end  
    end
  end

  get '/logout' do 
    if is_logged_in?
      logout!
      redirect to '/login'
    else 
      redirect '/'
    end 
  end

end