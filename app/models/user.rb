class User < ActiveRecord::Base
 
  has_many :exercises, :through => :user_exercises
  has_many :user_exercises
  has_many :entries

  has_many :exercises, :through => :entries 

  has_secure_password

end