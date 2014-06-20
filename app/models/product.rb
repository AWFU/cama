#encoding: utf-8
class Product < ActiveRecord::Base
  belongs_to :product_cate
  has_many :product_stocks, dependent: :destroy

  scope :front_show_by_cate, ->(product_cate_id) { where("product_cate_id = ? AND status = ?", product_cate_id, "enable") }

  validates_presence_of :name, :price, :price_for_sale, :product_cate_id

  before_validation :check_attrs

  def check_attrs
    self.name = "未命名商品" if self.name.blank?
    self.price = 0 if self.price.blank?
    self.price_for_sale = 0 if self.price_for_sale.blank?
    self.status = "disable" if self.status.blank?
  end

  def get_status
    case self.status
    when "disable"
      "下架"
    when "enable"
      "上架"
    end   
  end

  def is_available?
    self.status == "enable" ? true : false
  end
end
