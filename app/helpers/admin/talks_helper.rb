#encoding: utf-8
module Admin::TalksHelper

  def is_set_top(is_top)
    if is_top < 999
      image_tag "/images/admin/up.png", title: "置頂"
    end
  end

end
