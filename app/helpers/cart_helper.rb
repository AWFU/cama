#encoding: utf-8
module CartHelper
  require 'cart'
  def cart_product_count
    @cart_items = JSON.parse_if_json(cookies[:cart_cama]) || Hash.new
    cookies[:cart_cama] = Cart.check_cookies(@cart_items)

    return @cart_items.inject(0) { | sum, i | sum += i[1] }
  end

  def get_order_price(order_items)
    return @order_items.inject(0) { | sum, i | sum += ( i[:price_for_sale] > 0 ? i[:price_for_sale] : i[:price] ) * i[:amount] }
  end

  def no_order_items_msg(count)
    if(count == 0)
      '<tr><td align="center" colspan="9">購物車內沒有商品</td></tr>'.html_safe
    end
  end
end