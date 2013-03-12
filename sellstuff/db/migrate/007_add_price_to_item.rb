class AddPriceToItem < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.string :price
    end
  end

  def self.down
    change_table :items do |t|
      t.remove :price
    end
  end
end
