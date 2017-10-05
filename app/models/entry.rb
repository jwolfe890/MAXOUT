class Entry < ActiveRecord::Base

  belongs_to :user
  has_many :exercises, through: :exercise_entries 
  has_many :exercise_entries


  def self.edit_entry(params, entry)
    entry.exercise_entries.length.times do |i|
      entry.exercise_entries[i].weight = params[:weight][i]
      entry.exercise_entries[i].reps = params[:reps][i]
      entry.exercise_entries[i].save
    end 
  end


end