#encoding: utf-8
class Orderask < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :description

  before_validation :check_attrs

  def check_attrs
    self.status = "new" if self.status.blank?
  end

  def get_status
    case self.status
    when "new"
      "未處理"
    when "done"
      "已處理"
    end
  end
end
