module OrdersHelper
  def sum_order_items(order_items)
    return order_items.inject(0) { | sum, i | sum += i.item_price * i.amount }
  end

  def get_shipping_fee
    return 120
  end
end