class Entry < ActiveRecord::Base

  has_many :exercises
  belongs_to :user

end