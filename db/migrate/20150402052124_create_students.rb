class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :uin
      t.string :fname
      t.string :lname
      t.string :card
      t.string :email

      t.timestamps null: false
    end
  end
end
