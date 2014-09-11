class AddInnerStateAndWhodothisToOrderlogs < ActiveRecord::Migration
  def change
    add_column :orderlogs, :inner_state, :string
  end
end
