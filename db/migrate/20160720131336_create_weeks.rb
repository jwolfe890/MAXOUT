class CreateWeeks < ActiveRecord::Migration
  def change
     create_table :weeks do |t|
      t.string :name
      t.integer :user_id
    end
  end
end

