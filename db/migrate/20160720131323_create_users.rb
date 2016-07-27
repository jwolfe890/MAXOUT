class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.string :age
      t.integer :weight
      t.integer :week_id
      t.date :date
    end
  end
end

