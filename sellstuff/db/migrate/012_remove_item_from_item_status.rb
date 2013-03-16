class RemoveItemFromItemStatus < ActiveRecord::Migration
  def self.up
  	remove_column :item_statuses, :item
  end

  def self.down

  end
end
