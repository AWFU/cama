class AddShippingConditionToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :shipping_condition, :string
  end
end
