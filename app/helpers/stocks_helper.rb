#encoding: utf-8
module StocksHelper
  def show_stocks(stocks)
    if(stocks.length > 1)
      select_tag( "cart[stock]", generate_stock_options(stocks) )
    else
      hidden_field_tag( "cart[stock]", stocks.first.id )
    end
  end

  def generate_stock_options(stocks)
    @stock_options = String.new

    stocks.each do |stock|
      stock_name = stock.assign_amount ? "#{stock.name}：#{stock.amount}" : stock.name
      @stock_options += "<option value='#{stock.id}'>#{ stock_name }</option>"
    end

    return @stock_options.html_safe
  end

  def show_stock_amount(stock)
    if(stock.assign_amount)
      return " / 庫存數量：#{stock.amount}"
    end    
  end
end