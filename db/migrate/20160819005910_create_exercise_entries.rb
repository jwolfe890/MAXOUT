class CreateExerciseEntries < ActiveRecord::Migration
  def change
    create_table :exercise_entries do |t|
      t.integer :weight
      t.integer :reps
      t.integer :exercise_id
      t.integer :entry_id
    end
  end
end
