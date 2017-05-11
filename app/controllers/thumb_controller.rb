class ThumbController < ApplicationController

  def index
    width = 0
    height = 0
    filename = ""

    width = params[:width].to_i
    height = params[:height].to_i
    filename = params[:filename]
    extension = params[:extension]
    full_filename = "#{filename}.#{extension}"
    path = File.join(Rails.root,"public","images",width.to_s, height.to_s)

    path_filename =  File.join(path, full_filename)
    if not @bootstrapp.resizer_client.exists?(path_filename)

      @bootstrapp.resizer_client.check_directory(path)

      image_db = @bootstrapp.image_read_service.get_by_id(filename)
      image_download = @bootstrapp.resizer_client.download(image_db.origin_url)

      @bootstrapp.resizer_client.resize(image_download, path_filename, width, height)
    end

    send_file path_filename, {:type => MIME::Types.type_for(full_filename), :disposition => 'inline'}
  end
end
