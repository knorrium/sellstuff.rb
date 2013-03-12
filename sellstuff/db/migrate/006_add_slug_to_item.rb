class AddSlugToItem < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.string :permalink
    end
  end

  def self.down
    change_table :items do |t|
      t.remove :permalink
    end
  end
end
