class AddItemIdToItemStatus < ActiveRecord::Migration
  def self.up
    change_table :itemstatuses do |t|
      t.integer :item_id
    end
  end

  def self.down
    change_table :itemstatuses do |t|
      t.remove :item_id
    end
  end
end
