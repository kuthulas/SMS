class AddTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :kind, :string
  end
end
