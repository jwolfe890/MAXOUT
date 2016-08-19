class User < ActiveRecord::Base
 
  # has_many :exercises, :through => :user_exercises
  
  has_many :user_exercises
  has_many :entries

has_many :exercises, :through => :entries 


# This association is used to generate the exercises when creating 
# a new workout routine after one has already been created.
# It won't allow to me to run @user.exercises without it 




  has_secure_password
end



