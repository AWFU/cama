#encoding: utf-8
class Customizedpage < ActiveRecord::Base

  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy

  validates_presence_of :title
  
  before_validation :check_attrs
  
  def check_attrs
    self.title = "未命名文章" if self.title.blank?
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
