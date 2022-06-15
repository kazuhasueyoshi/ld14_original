class CreateMessage < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer  :chatroom_id
      t.integer  :user_id
      t.string   :body
      t.timestamps null: false
    end
  end
end
