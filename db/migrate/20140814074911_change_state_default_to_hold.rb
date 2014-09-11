class ChangeStateDefaultToHold < ActiveRecord::Migration
  def change
    change_column :orders, :aasm_state, :string, :default => 'hold'
  end
end
