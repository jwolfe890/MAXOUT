class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :weight
      t.integer :reps
      t.date :date
      t.integer :entry_id 
    end
  end
end

