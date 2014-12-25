#encoding: utf-8
class Talk < ActiveRecord::Base
  resourcify
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :camatalks

  belongs_to :article, :dependent => :destroy
  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy

  default_scope { order('talks.ranking ASC, talks.created_at DESC') }

  validates_presence_of :title
  
  before_validation :check_attrs
  
  paginates_per 3

  def check_attrs
    self.title = "未命名文章" if self.title.blank?
    self.subtitle = " " if self.subtitle.blank?
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
      [:title, :subtitle],
      [:title , Time.now.strftime('%Y') , :subtitle],
      [:title ,:subtitle, Time.now.strftime('%Y%m%d')]
    ]
  end

  def should_generate_new_friendly_id?
    title_changed?
  end


end
