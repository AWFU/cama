class Admin::PhotosController < AdminController
  def resize
  
    @photo = Photo.find( params[ :id ] )
  
    @path = "public/uploads/peditor/article/"+ @photo.article_id.to_s + "/" + @photo.id.to_s + "-" + @photo.name
    @resize_path = "public/uploads/peditor/article/"+ @photo.article_id.to_s + "/" + @photo.id.to_s + "-peditor-" + @photo.name
    
    image = MiniMagick::Image.open( @path )
    image.crop "#{params[:width]}x#{params[:height]}+#{params[:x1]}+#{params[:y1]}"
    
    image.write @resize_path
    
    respond_to do | format |
      format.js
    end
  
  end
end
