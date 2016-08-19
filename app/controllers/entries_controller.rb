class EntriesController < ApplicationController

# INDEX/LIST PAGE

  get '/entries' do
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/entries/list_page'
    else 
      redirect '/login'
    end 
  end 

# GET ROUTES TO CREATE A NEW ENTRY 

  # get '/entry/new' do
  #   HAS_MANY THROUGH VERSION 
  #   @user = User.find_by_id(session[:user_id])
  #   if is_logged_in? 
  #   if @user.entries != []
  #     names = []
  #     @user.exercises.each do |exer|
  #       names << exer.name
  #     end 
  #     @names2 = names.uniq
  #     erb :'/entries/create_entry2'
  #   else 
  #     names = []
  #     Exercise.all.each do |exer|
  #       names << exer.name
  #     end 
  #     @names2 = names.uniq
  #     erb :'entries/create_entry' 
  #   end 
  #  else 
  #   redirect '/login'
  #   end 
  # end

# MANY TO MANY VERSION

  get '/entry/new' do
    @user = User.find_by_id(session[:user_id])
    if is_logged_in? 
      names = []
      Exercise.all.each do |exer|
        names << exer.name
      end 
      @names2 = names.uniq
      erb :'entries/create_entry' 
    # end 
   else 
    redirect '/login'
    end 
  end

# POST ROUTE FOR CREATING A NEW EXERCISE

  post '/entry' do
    @user = User.find_by_id(session[:user_id])
    @entry = Entry.create
    @entry.date = params[:date]
    @entry.time = Time.now
    params["user"]["exercise_names"].each do |exer|  
       @entry.exercises << Exercise.create(name: exer, date: params[:date], time: Time.now) 
    end
    if !params[:exercise][:name].empty?
      @entry.exercises << Exercise.create(name: params[:exercise][:name], date: params[:date], time: Time.now)
    end
    @user.entries << @entry 
    redirect "add_stats?entry=#{@entry}" 
  end

  get '/add_stats' do
    if is_logged_in? 
      @user = User.find_by_id(session[:user_id])
      @entry = Entry.last
      erb :'entries/add_stats'
    else 
      redirect '/login'
    end 
  end

# POST ROUTE FOR ADDING STATS. ADDS THE EXERCISE STATS/NUMBERS AFTER A USER ENTERS THEM FOR A WORKOUT 
# IT HAS TO USE PATCH (BECAUSE IT'S CHANGING DATA, I BELIEVE)

  patch '/add_stats' do
    @user = User.find_by_id(session[:user_id])
    @entry = Entry.last
    weight_convertor = @entry.exercises.zip(params["weight"])
    weight_convertor.each do 
      |x| x[0].weight = x[1]
    end
    reps_convertor = @entry.exercises.zip(params["reps"]) 
    reps_convertor.each do 
      |x| x[0].reps = x[1] 
    end 
    @entry.exercises.each do |entry|
      entry.save
    end 
    redirect "show_stats?date=#{params[:time]}"
  end

# AFTER USER EDITS ENTRY IT GOES TO THIS CONTROLLER

  patch '/edit_entry' do
    @user = User.find_by_id(session[:user_id])
    @entry = Entry.last
    weight_convertor = @entry.exercises.zip(params["weight"])
    weight_convertor.each do 
      |x| x[0].weight = x[1]
    end
    reps_convertor = @entry.exercises.zip(params["reps"]) 
    reps_convertor.each do 
      |x| x[0].reps = x[1] 
    end 
    @entry.exercises.each do |entry|
      entry.save
    end 
    redirect "show_update?date=#{params[:time]}"
  end

  get '/show_stats' do
    # SHOWS THE STATS AFTER A USER CREATES A WORKOUT AND ENTERS THEM
    if is_logged_in? 
      @user = User.find_by_id(session[:user_id])
      @entry = Entry.last
      erb :'/entries/show_stats'
    else 
      redirect '/login'
    end 
  end

  get '/show_stats/:id' do
    # SHOWS THE STATS IF A USER SEARCHES AN ENTRY FROM THE LIST/INDEX PAGE
    if is_logged_in? 
      @user = User.find_by_id(session[:user_id])
      @entry = Entry.all.find_by_id(params[:id])
      erb :'/entries/show_stats'
    else 
      redirect '/login'
    end 
  end

  get '/edit_entry/:id' do
    # ALLOWS A USER TO EDIT AN ENTRY 
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      @entry = Entry.all.find_by_id(params[:id])
      erb :'entries/edit'
    else 
      redirect '/login'
    end  
  end

  get '/show_update' do 
    # SHOWS UPDATE AFTER USER EDITS STATS 
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/entries/show_update'
    else 
      redirect '/login'
    end  
  end     
 
end




