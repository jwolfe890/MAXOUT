class Exercise < ActiveRecord::Base

  has_many :users, :through => :user_exercises
  has_many :user_exercises
  belongs_to :user
  belongs_to :entry

end

