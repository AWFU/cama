class AddPaymentStatusAndShippingStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipped, :string, :default => "no"
    add_column :orders, :paid, :string, :default => "no"
  end
end
