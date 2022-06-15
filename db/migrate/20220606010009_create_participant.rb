class CreateParticipant < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.integer  :chatroom_id
      t.integer  :user_id
      t.timestamps null: false
    end
  end
end
