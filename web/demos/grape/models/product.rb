require 'active_record'

class Product < ActiveRecord::Base
	validates :name, :price, presence: true
	validates :name, length: { maximum: 128 }
	validates :price, numericality: true
end
