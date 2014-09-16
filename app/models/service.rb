#encoding: utf-8
class Service < ActiveRecord::Base
  has_many :store_service_ships, dependent: :destroy
  has_many :stores , through: :store_service_ships
  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  
  validates_presence_of :name

  before_validation :check_attrs

  def check_attrs
    self.name = "未命名服務" if self.name.blank?
  end
end
