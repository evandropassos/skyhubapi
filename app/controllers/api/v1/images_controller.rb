class Api::V1::ImagesController < Api::V1::BaseController
  attr_accessor :bootstrapp
  def index

    if @bootstrapp.image_read_service.total == 0
      @bootstrapp.image_write_service.populate_images
    end

    render json: { images: @bootstrapp.image_read_service.list.map { |e| e.formats } }

  end
end
