class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :student_id
      t.integer :univstudent_id
      t.integer :distinct_user
      t.string  :mail
      t.string  :password_digest
      t.integer :my_chatroom
      t.timestamps null: false
    end
  end
end
