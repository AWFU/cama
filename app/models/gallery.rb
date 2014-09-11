class Gallery < ActiveRecord::Base
  
  mount_uploader :attachment, GalleryUploader
  
  belongs_to :attachable, :polymorphic => true
  
  validates :attachable, :presence => true
  validates :attachment, :presence => true


  before_save :set_attachment_attributes

  protected

  def set_attachment_attributes
    if attachment.present? && attachment_changed?
      self.content_type = attachment.file.content_type
      self.file_size = attachment.file.size

      #self.file_name = attachment.file.original_filename if !self.file_name.present?
    end
  end

end


class IndexSliderGallery < Gallery

end

class ProductPhotoGallery < Gallery 

end

class TasteAttributeGallery < Gallery 

end

class StorePhotoGallery < Gallery 

end

class TalkCoverGallery < Gallery 

end

class AnnouncementCoverGallery < Gallery

end

class CustomizedpageCoverGallery < Gallery

end

class ServiceIconGallery < Gallery

end

class CategoryCoverGallery < Gallery
  
end
