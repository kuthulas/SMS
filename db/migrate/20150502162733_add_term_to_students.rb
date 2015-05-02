class AddTermToStudents < ActiveRecord::Migration
  def change
    add_column :students, :term, :string, :default => ""
  end
end
