class CreateStudent < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string  :school_name
      t.string  :free_body
      t.timestamps null: false
    end
  end
end
