class AddSlugToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :slug, :string , :unique => true
  end
end
