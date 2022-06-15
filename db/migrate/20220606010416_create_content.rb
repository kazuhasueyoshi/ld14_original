class CreateContent < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.integer  :user_id
      t.string   :title
      t.string   :body
      t.string   :img
      t.timestamps null: false
    end
  end
end
