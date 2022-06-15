class CreateChatroom < ActiveRecord::Migration[6.1]
  def change
    create_table :chatrooms do |t|
      t.timestamps null: false
    end
  end
end
