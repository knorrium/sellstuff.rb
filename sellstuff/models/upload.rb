require 'carrierwave/orm/activerecord'
class Upload < ActiveRecord::Base

   mount_uploader :file, Uploader

   belongs_to :item
end
