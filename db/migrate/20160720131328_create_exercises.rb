class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.datetime :time
      t.datetime :date
      t.integer :entry_id 
    end
  end
end

