class WeeksController < ApplicationController

  get '/weeks' do 
    erb :'/weeks/weeks'
  end

  get '/weeks/new' do

     if is_logged_in?

        @user = User.find_by(:id => session[:user_id])

        erb :'/weeks/create_week'
      else 
        redirect to '/login'
      end  

  end

  post '/weeks' do 

    binding.pry

    @user = User.find_by(:id => session[:user_id])

    @user.exercises << params[user][exercise_ids]

    binding.pry

    if !params[:exercise][:name].empty?
      @user.exercises << Title.create(params[:title])
    end
    # THIS IS FOR ADDING AN EXERCISE 

    redirect to ''

  end


 
end