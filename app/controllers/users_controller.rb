class UsersController < ApplicationController

  get '/signup' do
    if !is_logged_in?
      erb :'users/create_user'
    else
      logout! 
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if User.find_by(:username => params[:user][:username])
      erb :'users/create_user', locals: {message: "BRO, DO YOU EVEN LIFT?? THAT NAME IS TAKEN!"}
    elsif params[:user][:username] == "" || params[:user][:password] == ""
      erb :'users/create_user', locals: {message: "YOU HAVE TO ENTER A NAME AND PASSWORD, WIMP!"}
    else 
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect to '/entry/new'
  end  
  end

  get '/login' do 
    if is_logged_in?
      redirect '/entries'
    else 
      erb :'users/login'
    end
  end 
# NEEDS TO INCLUDE AN ERROR MESSAGE IF THEY AREN'T LOGGED IN 

  post '/login' do
     user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/entries'
    else
      redirect to '/signup'
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