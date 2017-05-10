require File.join(Rails.root, "lib/core/resizer/resizer")
require File.join(Rails.root, "lib/core/imagebank/imagebank")
require File.join(Rails.root, "lib/service/image/image_service")

class Skyhubapi::Bootstrapper
  attr_accessor :image_read_service, :image_write_service

  def initialize
    resizer_client = Resizer::Client.new(Resizer::Providers::MiniMagic.new(File.join(Rails.root, "tmp", "images"), 80))
    imagebank = ImageBank::Client.new(ImageBank::Providers::B2w.new("http://54.152.221.29/images.json"))


    @image_read_service = Service::Image::ImageReadService.new
    @image_write_service = Service::Image::ImageWriteService.new(imagebank, resizer_client)
  end
end
