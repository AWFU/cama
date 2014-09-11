class AddAasmstateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :aasm_state, :string, :default => "new"
    add_index :orders, :aasm_state
  end
end
