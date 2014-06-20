class Orderitem < ActiveRecord::Base
  require "cart"
  belongs_to :order

  def self.record_orderitems(order, cookies_cart)
    order.orderitems.create( Cart.check_items_in_cart(cookies_cart, "for_order") )
  end
end
