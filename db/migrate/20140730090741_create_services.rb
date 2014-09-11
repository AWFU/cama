class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :reference_count

      t.timestamps
    end
  end
end
