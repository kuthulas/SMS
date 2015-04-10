class ChangeDataTypeForUin < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.change :uin, :string
    end
  end

  def self.down
    change_table :students do |t|
      t.change :uin, :integer
    end
  end
end
