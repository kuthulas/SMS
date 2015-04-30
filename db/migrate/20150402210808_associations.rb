class Associations < ActiveRecord::Migration
  def change
  	add_column :checkins, :student_id, :integer
  	add_column :checkins, :event_id, :integer
  end
end
