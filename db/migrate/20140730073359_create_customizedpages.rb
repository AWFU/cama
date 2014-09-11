class CreateCustomizedpages < ActiveRecord::Migration
  def change
    create_table :customizedpages do |t|
      t.string :title
      t.string :subtitle
      t.integer :ranking, :null => false, :default => 999
      t.string :status
      t.text :html_content
      t.text :js_content

      t.timestamps
    end
  end
end
