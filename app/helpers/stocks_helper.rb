#encoding: utf-8
module StocksHelper
  def show_stock(stock)
    stock.assign_amount ? "#{stock.name}：#{stock.amount}" : stock.name    
  end
end