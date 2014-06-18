class Product < ActiveRecord::Base
	belongs_to :product_cate
	has_many :product_stocks

	validates_presence_of :name, :price, :productCate_id
end
