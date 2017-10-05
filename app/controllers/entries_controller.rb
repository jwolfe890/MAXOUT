class EntriesController < ApplicationController

  get '/entries' do
    if is_logged_in?
      binding.pry
      @user = User.find_by_id(session[:user_id])
      erb :'/entries/list_page'
    else 
      redirect '/login'
    end 
  end 

  get '/entry/new' do
    @user = User.find_by_id(session[:user_id])
    if is_logged_in? 
      @names = []
      Exercise.all.each do |exercise|
        @names << exercise.name
      end 
      erb :'entries/create_entry' 
   else 
    redirect '/login'
    end 
  end

  post '/entry' do
    @user = User.find_by_id(session[:user_id])
    @entry = Entry.create
    @entry.date = params[:date]
    @entry.time = Time.now
    params["user"]["exercise_names"].each do |exercise|  
       @entry.exercises << Exercise.find_by(name: exercise) 
    end
    @user.entries << @entry
    @user.save
    @entry.save 
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

  patch '/add_stats' do
    @user = User.find_by_id(session[:user_id])
    @entry = Entry.last
    @entry.exercise_entries.each do |exEntry|
      id = exEntry.id.to_s
      exEntry.weight = params[:exercise_entry_ids][id][:weight]
      exEntry.reps = params[:exercise_entry_ids][id][:reps]
    end
      redirect "show_stats?date=#{params[:time]}"
  end

  patch '/edit_entry' do
    @user = User.find_by_id(session[:user_id])
    @entry = Entry.last
      @entry.exercise_entries.each do |exEntry|
        id = exEntry.id.to_s
        exEntry.weight = params[:exercise_entry_ids][id][:weight]
        exEntry.reps = params[:exercise_entry_ids][id][:reps]
        exEntry.save
      end
    redirect '/show_stats'
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




