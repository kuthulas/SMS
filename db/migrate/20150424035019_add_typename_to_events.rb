class AddTypenameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :typename, :string
  end
end
