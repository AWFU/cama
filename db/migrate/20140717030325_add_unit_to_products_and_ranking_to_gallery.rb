class AddUnitToProductsAndRankingToGallery < ActiveRecord::Migration
  def change
    add_column :products, :unit, :string
    add_column :galleries, :ranking, :integer, :null => false, :default => 999
  end
end
