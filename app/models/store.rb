#encoding: utf-8
class Store < ActiveRecord::Base
  
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :locations

  has_many :store_service_ships
  has_many :services , through: :store_service_ships

  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy

  default_scope { order('city ASC, district ASC') }
  
  before_validation :check_attrs
  validates_presence_of :name 

  paginates_per 10

  def check_attrs
    self.name = "untitled" if self.name.blank?
  end

  # def get_status
  #   case self.status
  #   when "disable"
  #     "下架"
  #   when "enable"
  #     "上架"
  #   end   
  # end
  def self.served_with(name)
    Service.find_by_name!(name).stores
  end

  def self.service_counts
    Service.select("services.*, count(services.service_id) as count").
      joins(:store_service_ships).group("store_service_ships.service_id")
  end

  def service_list
    services.map(&:name).join(", ")
  end

  def service_list=(names)
    self.services = names.split(",").map do |n|
      Service.where(name: n.strip).first_or_create!
    end
  end

  extend FriendlyId
  require "babosa"
  friendly_id :slug_candidates , use: [:slugged, :history]
  
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def slug_candidates
    [
      :name,
      [:name, :phone]
    ]
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

end
