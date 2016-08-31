class Entry < ActiveRecord::Base

  belongs_to :user
  has_many :exercises, through: :exercise_entries 
  has_many :exercise_entries

end