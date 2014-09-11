class CreateStoreServiceShips < ActiveRecord::Migration
  def change
    create_table :store_service_ships do |t|
      t.belongs_to :service, index: true
      t.belongs_to :store, index: true

      t.timestamps
    end
  end
end
