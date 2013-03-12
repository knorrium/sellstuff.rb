class AddItemPicture < ActiveRecord::Migration
  def self.up
  	add_column :items, :picture, :string
  end

  def self.down
  	remove_column :items, :picture
  end
end
