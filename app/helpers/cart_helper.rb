module CartHelper
  require 'cart'
  def cart_product_count
    @cart_items = JSON.parse_if_json(cookies[:cart_cama]) || Hash.new
    cookies[:cart_cama] = Cart.check_cookies(@cart_items)

    return @cart_items.inject(0) { | s, i | s += i[1] }
  end
end