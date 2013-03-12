class Item < ActiveRecord::Base
	mount_uploader :picture, Uploader

	has_permalink :title

	validates_presence_of :title
	validates_presence_of :description

	validates_uniqueness_of :title

	validates_presence_of :title
	validates_presence_of :description
end
