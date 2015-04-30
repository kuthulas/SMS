class AddIndueventnumToStudents < ActiveRecord::Migration
  def change
    add_column :students, :indevents, :integer, :default => 0
  end
end
