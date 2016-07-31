class EntriesController < ApplicationController

  get '/entries' do
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/entries/list_page'
    else 
      redirect '/login'
    end 
  end 

  get '/entry/new' do
    @user = User.find_by_id(session[:user_id])
    if is_logged_in? 
    if @user.entries != []
      names = []
      @user.exercises.each do |exer|
        names << exer.name
      end 
      @names2 = names.uniq
      erb :'/entries/create_entry2'
    else 
      names = []
      Exercise.all.each do |exer|
        names << exer.name
      end 
      @names2 = names.uniq
      erb :'entries/create_entry' 
    end 
   else 
    redirect '/login'
    end 
  end

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
    if is_logged_in? 
      @user = User.find_by_id(session[:user_id])
      @entry = Entry.last
      erb :'/entries/show_stats'
    else 
      redirect '/login'
    end 
  end

  get '/show_stats/:id' do
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
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/entries/show_update'
    else 
      redirect '/login'
    end  
  end     
 
end




