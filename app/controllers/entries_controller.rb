class EntriesController < ApplicationController

  get '/entries' do
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      binding.pry
      erb :'/entries/list_page'
    else 
      redirect '/login'
    end 
  end 

  get '/entry/new' do
    binding.pry
    
    names = []
    
    Exercise.all.each do |exer|
      names << exer.name
    end 

    @names2 = names.uniq

    if is_logged_in? 
      binding.pry
       @user = User.find_by_id(session[:user_id])
       erb :'entries/create_entry' 
    else 
      redirect '/login'
    end 
  end

  post '/entry' do
    @user = User.find_by_id(session[:user_id])
    params["user"]["exercise_names"].each do |exer|  
       @user.exercises << Exercise.create(name: exer, date: params["date"])
    end 
    redirect "add_stats?date=#{params[:date]}" 
  end

  get '/add_stats' do
    if is_logged_in?  
      binding.pry
      @user = User.find_by_id(session[:user_id])
      @date = params[:date]
      @user.date = @date 
      @entry = Entry.create 
      @entry.name = @date
      @entry.date = @date  
      @entry.exercises << @user.exercises.all.where(date: "#{@date}" )
      @user.entries << @entry
      @user.save
      @entry.save  
      erb :'entries/add_stats'
    else 
      redirect '/login'
    end 
  end

  patch '/add_stats' do
    binding.pry
    @user = User.find_by_id(session[:user_id])
    @entry = @user.exercises.all.where(date: "#{@user.date}" )
    weight_convertor = @entry.zip(params["weight"])
    weight_convertor.each do 
      |x| x[0].weight = x[1]
    end
    reps_convertor = @entry.zip(params["reps"]) 
    reps_convertor.each do 
      |x| x[0].reps = x[1] 
    end 
    @entry.each do |entry|
      entry.save
    end 
    redirect "show_stats?date=#{params[:date]}"
  end

  patch '/edit_entry' do
    @user = User.find_by_id(session[:user_id])
    @entry = @user.exercises.all.where(date: "#{@user.date}" )
    weight_convertor = @entry.zip(params["weight"])
    weight_convertor.each do 
      |x| x[0].weight = x[1]
    end
    reps_convertor = @entry.zip(params["reps"]) 
    reps_convertor.each do 
      |x| x[0].reps = x[1] 
    end 
    @entry.each do |entry|
      entry.save
    end 
    redirect "show_update?date=#{params[:date]}"
  end

  get '/show_stats' do
    if is_logged_in? 
      binding.pry
      @user = User.find_by_id(session[:user_id])
      @entry = @user.exercises.all.where(date: "#{@user.date}" )
      erb :'/entries/show_stats'
    else 
      redirect '/login'
    end 
  end

  get '/show_stats/:date' do
    if is_logged_in? 
      binding.pry
      @user = User.find_by_id(session[:user_id])
      @user.date = params["date"]
      @user.save
      @entry = @user.exercises.all.where(date: params[:date] )
      erb :'/entries/show_stats'
    else 
      redirect '/login'
    end 
  end

  get '/edit_entry/:date' do
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      @user.date = params["date"]
      @user.save
      @entry = @user.exercises.all.where(date: params["date"] )
      erb :'entries/edit'
    else 
      redirect '/login'
    end  
  end

  get '/show_update' do 
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      @entry = @user.exercises.all.where(date: "#{@user.date}" )
      erb :'/entries/show_update'
    else 
      redirect '/login'
    end  
  end     
 
end




