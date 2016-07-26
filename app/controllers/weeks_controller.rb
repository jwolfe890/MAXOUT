class WeeksController < ApplicationController

  # get '/weeks' do 
  #   erb :'/weeks/weeks'
  # end

  # get '/weeks/:id' do 
  #   # SHOWS THE INFORMATION FOR A SPECIFIC WEEK
  # end 

  # get '/weeks/:id/edit' do 
  #   # ALLOWS USER TO EDIT THAT SPECIFIC WEEK
  # end

  # post '/weeks/:id' do 
  #   # UPDATES THAT SPECIFIC WEEK 

  #   redirect to '/weeks/:id'

  # end  

  get '/weeks/new' do
      if is_logged_in?
        @user = User.find_by(:id => session[:user_id])
        erb :'/weeks/create_week'
      else 
        redirect to '/login'
      end  
  end

  post '/weeks' do  

    @user = User.find_by(:id => session[:user_id])
    # @week = Week.new

    @user.exercise_ids = params["user"]["exercise_ids" ].map(&:to_i)

     binding.pry

    if !params[:exercise][:name].empty?
      @user.exercises << Title.create(params[:title])
    end

    # @week1.exercises << params["user"]["exercise_ids" ].map(&:to_i)
    # @user.weeks << @week1

    redirect to 'weeks2'
  end

  get '/weeks2' do 
    @user = User.find_by(:id => session[:user_id])
    erb :'/weeks/week2'
  end

  get '/weeks2' do 

  end  

  # post '/weeks' do

  #   # UPDATE THE SPECIFIC WEEK 
    
  #   redirect to '/weeks'
  # end  

 
end