class ItemStatus < ActiveRecord::Base
	belongs_to :item

	validates_presence_of :name
end
