class Category < ActiveRecord::Base
	belongs_to :item
	has_permalink :name
	validates_uniqueness_of :name
end
