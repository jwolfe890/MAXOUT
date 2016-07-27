class WeeksController < ApplicationController

  gets '/weeks' do
    @user = User.find_by_id(session[:user_id])
  end 

  get '/weeks/new' do 
    @user = User.find_by_id(session[:user_id])
    erb :'weeks/create_week' 
  end

  post '/weeks' do 
    @user = User.find_by_id(session[:user_id])
    params["user"]["exercise_names"].each do |exer|  
       @user.exercises << Exercise.create(name: exer, date: params["date"])
    end 
    redirect "week2?date=#{params[:date]}" 
  end

  get '/week2' do
    @entry = []
    @user = User.find_by_id(session[:user_id])
    @date = params[:date]
    @user.date = @date
    @user.save
    @entry = @user.exercises.all.where(date: "#{@date}" )
    # @entry = Entry.create
    # @entry.name = @date
    # @entry.date = date  
    # @entry.exercises << @user.exercises.all.where(date: "#{@date}" )
    # @user.entries << @entry 
    erb :'weeks/week2'
  end

  patch '/week2' do
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
    redirect "week3?date=#{params[:date]}"
  end

  patch '/week22' do
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
    redirect "week33?date=#{params[:date]}"
  end

  get '/week3' do 
    @user = User.find_by_id(session[:user_id])
    @entry = @user.exercises.all.where(date: "#{@user.date}" )
    erb :'/weeks/week3'
  end

  get '/week2/:date' do
    @user = User.find_by_id(session[:user_id])
    @entry = @user.exercises.all.where(date: params["date"] )
    binding.pry 
    erb :'weeks/edit'
  end

  get '/week33' do 
    @user = User.find_by_id(session[:user_id])
    @entry = @user.exercises.all.where(date: "#{@user.date}" )
    erb :'/weeks/update'
  end     
 
end




