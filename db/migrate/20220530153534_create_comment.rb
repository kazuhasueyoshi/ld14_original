class CreateComment < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :good, default: 0
      t.string :body
      t.integer :contribution_id
      t.timestamps null: false
    end
  end
end
