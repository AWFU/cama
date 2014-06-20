#encoding: utf-8
class Cart
  def self.check_cookies(cart_items)
    cart_items.each do | key, num |
      @stock = ProductStock.find_by_id(key)
      cart_items.delete(key) unless @stock
    end

    cart_items.to_json
  end

  def self.check_stock(cookies_cart, stock, ask_amount)
    @cart_items = JSON.parse_if_json(cookies_cart) || Hash.new
    @amount_in_need = (@cart_items[stock.id] || 0) + ask_amount

    if(stock.assign_amount && (stock.amount < @amount_in_need))
      @cart_message = "放入購物車的商品數量超過商品庫存！"
    else
      @cart_items[stock.id] = @amount_in_need
      @cart_message = "已新增至購物車"
    end

    return { cart_items: @cart_items.to_json, cart_message: @cart_message }
  end

  private

end