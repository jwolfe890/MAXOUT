class CreateExerciseWeeks < ActiveRecord::Migration
  def change
    create_table :exercise_weeks do |t|
      t.integer :exercise_id
      t.integer :week_id
    end
  end
end
