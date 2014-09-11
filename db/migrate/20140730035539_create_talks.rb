class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title
      t.integer :ranking, :null => false, :default => 999
      t.integer :article_id

      t.timestamps
    end
  end
end
