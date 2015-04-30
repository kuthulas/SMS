class AddDepteventnumToStudents < ActiveRecord::Migration
  def change
    add_column :students, :deptevents, :integer, :default => 0
  end
end
