#encoding: utf-8
class Job < ActiveRecord::Base
  
  before_validation :check_attrs
  validates_presence_of :name, :websiteurl

  def check_attrs
    self.name = "untitled" if self.name.blank?
    self.websiteurl = "http://www.google.com.tw" if self.websiteurl.blank?
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

end
