class ChangeDeliveriesForDiscountFee < ActiveRecord::Migration
  def change
    rename_column :deliveries, :fee_per_item, :normal_fee

    add_column :deliveries, :discount_criteria, :integer, :default => 1500
    add_column :deliveries, :discount_fee, :integer, :default => 0

  end
end
