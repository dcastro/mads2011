class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :hashed_password
      t.string :salt
      t.string :name
      t.string :email
      t.string :contact
      t.string :photo

      t.timestamps
    end
  end
end
