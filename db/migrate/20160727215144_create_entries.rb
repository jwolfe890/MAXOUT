class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.date :name
      t.date :date
      t.datetime :time
      t.integer :user_id
    end
  end
end
