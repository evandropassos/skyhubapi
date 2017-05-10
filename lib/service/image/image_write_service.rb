class Service::Image::ImageWriteService

  def initialize(imagebank, resizer_client)
    @imagebank = imagebank
    @resizer_client = resizer_client
  end

  def populate_images
    data_images = @imagebank.fetch

    data_images.each do |item|
      @resizer_client.download(item.url)
    end
  end
end
