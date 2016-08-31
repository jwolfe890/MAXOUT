class Exercise < ActiveRecord::Base

  has_many :entries, through: :exercise_entries 
  has_many :exercise_entries

end

