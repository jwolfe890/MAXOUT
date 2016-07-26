class Exercise < ActiveRecord::Base

  has_many :users, :through => :user_exercises
  has_many :user_exercises

  belongs_to :user

  # has_many :weeks, :through => :exercise_weeks
  # has_many :exercise_weeks

end

