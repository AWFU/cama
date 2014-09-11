class Role < ActiveRecord::Base
  #role of admin
  has_and_belongs_to_many :admins, :join_table => :admins_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
