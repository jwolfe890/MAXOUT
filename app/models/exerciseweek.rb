class ExerciseWeek < ActiveRecord::Base
 
  belongs_to :exercise
  belongs_to :week

end