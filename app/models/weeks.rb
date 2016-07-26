class Week < ActiveRecord::Base
 
  # belongs_to :user

  # has_many :exercises, :through => :exercise_weeks
  # has_many :exercise_weeks

  has_many :exercises, :through => :users

end