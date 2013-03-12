class AddItemToUpload < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.integer :item_id
    end
  end

  def self.down
    change_table :uploads do |t|
      t.remove :item_id
    end
  end
end
