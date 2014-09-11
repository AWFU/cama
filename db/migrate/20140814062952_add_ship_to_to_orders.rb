class AddShipToToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ship_to, :string
  end
end
