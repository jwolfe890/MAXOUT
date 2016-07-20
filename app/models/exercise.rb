class Exercise < ActiveRecord::Base

  has_many :users, :through => :user_exercises
  has_many :user_exercises

end