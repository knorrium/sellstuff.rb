class AddItemStatusesToItem < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.integer :status_id
    end
  end

  def self.down
    change_table :items do |t|
      t.remove :status_id
    end
  end
end
