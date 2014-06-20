#encoding: utf-8
class Cart
  def self.check_cookies(cart_items)
    cart_items.each do | key, num |
      @stock = ProductStock.includes(:product).find_by_id(key)
      cart_items.delete(key) unless(@stock && @stock.product.is_available?)
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

  def self.check_items_in_cart(cookies_cart)
    @cart_items = JSON.parse_if_json(cookies_cart) || Hash.new
    @stocks = ProductStock.includes(:product).where(:id => @cart_items.keys)

    @order_items = Array.new

    @stocks.each do |stock|
      if(stock.assign_amount)
        if(stock.amount > @cart_items[stock.id.to_s].to_i)
          @product_amount = { :amount => @cart_items[stock.id.to_s].to_i }
        else
          @product_amount = { :amount => stock.amount.to_i }
        end
      else
        @product_amount = { :amount => @cart_items[stock.id.to_s].to_i }
      end

      @product_attrs = { :id => stock.id, :name => stock.product.name, :stock_name => stock.name, :image => nil, :price => stock.product.price.to_i, :price_for_sale => stock.product.price_for_sale.to_i }
      @order_items.push( @product_attrs.merge(@product_amount) )
    end

    return @order_items
  end

  def self.plus_stock(cookies_cart, stock_id)
    @cart_items = JSON.parse_if_json(cookies_cart) || Hash.new
    @stock = ProductStock.find_by_id(stock_id)

    if(!@stock.assign_amount || @cart_items[stock_id] < @stock.amount)
      @cart_items[stock_id] += 1
    else
      @cart_message = "訂購數量到達庫存上限"
    end

    return { cart_items: @cart_items.to_json, cart_message: @cart_message }
  end

  def self.minus_stock(cookies_cart, stock_id)
    @cart_items = JSON.parse_if_json(cookies_cart) || Hash.new

    if(@cart_items[stock_id].to_i > 1)
      @cart_items[stock_id] -= 1
    end

    return { cart_items: @cart_items.to_json, cart_message: @cart_message }
  end

  def self.delete_stock(cookies_cart, stock_id)
    @cart_items = JSON.parse_if_json(cookies_cart) || Hash.new
    @cart_items.delete(stock_id)

    return { cart_items: @cart_items.to_json, cart_message: @cart_message }
  end

  private

end