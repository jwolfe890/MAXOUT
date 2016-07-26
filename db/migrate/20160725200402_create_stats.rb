class CreateStats < ActiveRecord::Migration
  def change
        create_table :stats do |t|
      t.date :date
      t.integer :weight 
      t.integer :reps
      t.integer :user_exercise_id
    end
  end
end
