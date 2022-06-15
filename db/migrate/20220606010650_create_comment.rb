class CreateComment < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer  :user_id
      t.integer  :content_id
      t.string   :body
      t.timestamps null: false
    end
  end
end
