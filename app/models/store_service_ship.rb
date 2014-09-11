class StoreServiceShip < ActiveRecord::Base
  belongs_to :service
  belongs_to :store
  
end
