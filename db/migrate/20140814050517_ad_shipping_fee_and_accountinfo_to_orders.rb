class AdShippingFeeAndAccountinfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :accountinfo, :string
    add_column :orders, :shipping_fee, :integer
  end
end
