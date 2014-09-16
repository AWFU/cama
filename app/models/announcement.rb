#encoding: utf-8
class Announcement < ActiveRecord::Base
  resourcify
  belongs_to :article, :dependent => :destroy
  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  
  #default_scope { order('ranking ASC, created_at') }
  scope :for_index, -> { where(status: "enable").order('ranking ASC, created_at DESC') }  
  scope :for_admin, -> { order('ranking ASC, created_at DESC') }  
  # for next, previous page in show action
  # scope :next_page, lambda {|id| where("id > ? and status = ?",id, 'enable').order("ranking ASC, created_at ASC, id ASC") } # this is the default ordering for AR
  # scope :previous_page, lambda {|id| where("id < ? and status = ? ",id, 'enable').order("ranking DESC, created_at DESC, id DESC") }

  # def next
  #   Announcement.next_page(self.id).first
  # end

  # def previous
  #   Announcement.previous_page(self.id).first
  # end
  # for next, previous page in show action ＥＮＤ

  validates_presence_of :title
  
  before_validation :check_attrs
  
  paginates_per 10
    
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

  extend FriendlyId
  require "babosa"
  friendly_id :slug_candidates , use: [:slugged, :history]
  
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def slug_candidates
    [
      :title,
      [:title , :subtitle],
      [:title , Time.now.strftime('%Y') , :subtitle],
      [:title ,:subtitle, Time.now.strftime('%Y%m%d')]
    ]
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

end
  

class PeditorAnnouncement < Announcement
  
end

class CustomizedAnnouncement < Announcement
  
end