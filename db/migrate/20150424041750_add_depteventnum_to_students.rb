class AddDepteventnumToStudents < ActiveRecord::Migration
  def change
    add_column :students, :depteventnum, :integer, :default => 0
  end
end
