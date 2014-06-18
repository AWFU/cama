class ProductStock < ActiveRecord::Base
	belongs_to :product

	validates_presence_of :name, :amount, :product_id
end
