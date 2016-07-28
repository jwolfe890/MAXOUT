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
    if User.find_by(:username => params[:username])
      erb :'users/create_user', locals: {message: "BRO, DO YOU EVEN LIFT?? THAT NAME IS TAKEN!"}
    elsif params[:username] == "" || params[:password] == ""
      erb :'users/create_user'
    else 
      @user = User.new(:username => params[:username], :password_digest => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/entry/new'
  end  
  end

  get '/login' do 
    if is_logged_in?
      redirect '/entries/new'
    else 
      erb :'users/login'
    end
  end 
# NEEDS TO INCLUDE AN ERROR MESSAGE IF THEY AREN'T LOGGED IN 

  post '/login' do
    binding.pry
     user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
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