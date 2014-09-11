class AddOrderMemoAndHumanMemoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_memo, :text
    add_column :orders, :human_involved_memo, :text
  end
end
