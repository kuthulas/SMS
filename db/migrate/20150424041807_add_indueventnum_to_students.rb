class AddIndueventnumToStudents < ActiveRecord::Migration
  def change
    add_column :students, :indueventnum, :integer, :default => 0
  end
end
