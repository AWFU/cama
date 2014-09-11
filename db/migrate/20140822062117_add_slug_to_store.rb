class AddSlugToStore < ActiveRecord::Migration
  def change
    add_column :stores, :slug, :string , :unique => true
  end
end
