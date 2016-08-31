class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.datetime :time 
      t.datetime :date
      t.string :name
    end
  end
end

