#encoding: utf-8
class Product < ActiveRecord::Base
  resourcify
  belongs_to :product_cate
  belongs_to :article, :dependent => :destroy

  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy

  has_many :product_stocks, dependent: :destroy

  scope :front_show_by_cate, ->(product_cate_id) { where("product_cate_id = ? AND status = ?", product_cate_id, "enable") }

  store :keypoints, accessors: [ :kp_1, :kp_2, :kp_3, :kp_4, :kp_5 ]
  store :taste_attributes, accessors: [ :taste_1, :taste_2, :taste_3, :taste_4, :taste_5, :taste_6 ]
  store :grind_level, accessors: [ :gl_1, :gl_2, :gl_3, :gl_4, :gl_5 ]

  validates_presence_of :name, :price, :price_for_sale, :product_cate_id
  validates_numericality_of :price , :only_integer => true , :greater_than_or_equal_to => :price_for_sale, :unless => "price_for_sale.nil?" 
  validates_numericality_of :price_for_sale , :only_integer => true , :greater_than => 0

  #validate > 0 ?
  before_validation :check_attrs

  def check_attrs
    self.name = "未命名商品" if self.name.blank?
    self.price = 9999 if self.price.blank?
    self.price_for_sale = 9999 if self.price_for_sale.blank?
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

  def is_grindable?
    self.grindable == 1 ? true : false
  end
end
