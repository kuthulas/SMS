class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :year
      t.string :term
      t.date :date
      t.string :location
      t.string :time

      t.timestamps null: false
    end
  end
end
