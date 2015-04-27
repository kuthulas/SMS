class AddTypedetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :typedetails, :string
  end
end
