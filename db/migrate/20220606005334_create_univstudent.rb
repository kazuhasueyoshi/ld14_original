class CreateUnivstudent < ActiveRecord::Migration[6.1]
  def change
    create_table :univstudents do |t|
      t.string :name
      t.string  :univ_name
      t.string  :undergraduate_name
      t.string  :department_name
      t.string  :circle_name
      t.string  :free_body
      t.timestamps null: false
    end
  end
end
