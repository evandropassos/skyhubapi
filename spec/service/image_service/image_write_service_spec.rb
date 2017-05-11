require 'rails_helper'

describe "ImageWriteService"  do
  before do
    resizer_client = Resizer::Client.new(Resizer::Providers::MiniMagic.new(80))
    imagebank = ImageBank::Client.new(ImageBank::Providers::B2w.new("http://54.152.221.29/images.json"))
    @image_write_service = Service::ImageService::ImageWriteService.new(imagebank, resizer_client, "http://localhost:3000")
  end

  context "populate_images" do
    it 'return 10 images' do
      result = @image_write_service.populate_images

      expect(result.length).to eq(10)
    end
  end
end
