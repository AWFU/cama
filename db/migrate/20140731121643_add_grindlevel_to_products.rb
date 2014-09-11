class AddGrindlevelToProducts < ActiveRecord::Migration
  def change
    add_column :products, :grind_level, :text
  end
end
