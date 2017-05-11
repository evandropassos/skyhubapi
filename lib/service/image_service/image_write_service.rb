class Service::ImageService::ImageWriteService

  def initialize(imagebank, resizer_client, urlapi)
    @imagebank = imagebank
    @resizer_client = resizer_client
    @urlapi = urlapi
  end

  def populate_images
    data_images = @imagebank.fetch

    data_images.each do |item|
      new_image = Image.new({
        origin_url: item.url
        })
      new_image.save!

      formats = []
      new_file = new_image._id
      extension = @resizer_client.get_extension_by_url(new_image.origin_url)
      formats << _build_url_format(new_file, @resizer_client.get_dimensions_size(:small), extension)
      formats << _build_url_format(new_file, @resizer_client.get_dimensions_size(:medium), extension)
      formats << _build_url_format(new_file, @resizer_client.get_dimensions_size(:large), extension)

      new_image.formats = formats
      new_image.save!
    end
  end
  
  private
  def _build_url_format(new_file, dimensions, extension)
    "#{@urlapi}/thumb/#{dimensions[:w]}/#{dimensions[:h]}/#{new_file}#{extension}"
  end
end
