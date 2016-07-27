class WeeksController < ApplicationController

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
    erb :'weeks/week2'
  end

  patch '/week2' do

    binding.pry

    @user = User.find_by_id(session[:user_id])

    @entry = @user.exercises.all.where(date: "#{@user.date}" )

    # weight_convertor = @entry.zip(params["weight"])
    # weight_convertor.each do 
    #   |x| x[0].weight = x[1]
    # end

    # reps_convertor = @entry.zip(params["reps"]) 
    # reps_convertor.each do 
    #   |x| x[0].reps = x[1] 
    # end 

    # @entry.each do |entry|
    #   entry.save
    # end 

    binding.pry

    redirect "week3?date=#{params[:date]}"
  end  
 
end




