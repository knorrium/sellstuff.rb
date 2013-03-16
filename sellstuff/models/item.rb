class Item < ActiveRecord::Base
	mount_uploader :picture, Uploader

	has_permalink :title

	has_one :item_status

	validates_presence_of :title
	validates_presence_of :description

	validates_uniqueness_of :title

	validates_presence_of :title
	validates_presence_of :description
end
