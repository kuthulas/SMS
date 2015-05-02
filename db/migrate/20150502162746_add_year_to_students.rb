class AddYearToStudents < ActiveRecord::Migration
  def change
    add_column :students, :year, :string, :default => ""
  end
end
