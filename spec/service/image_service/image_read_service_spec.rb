require 'rails_helper'

describe "ImageReadService"  do
  before do
    @image_read_service = Service::ImageService::ImageReadService.new
  end

  context "total method" do
    it 'return zero' do
      result = @image_read_service.total

      expect(result).to eq(0)
    end

    it 'return 1' do
      create(:basic_image)
      result = @image_read_service.total

      expect(result).to eq(1)
    end
  end

  context "list" do
    it "return empty array" do
      result = @image_read_service.list

      expect(result.length).to eq(0)
    end

    it "return array length 1" do
      create(:basic_image)
      result = @image_read_service.list

      expect(result.length).to eq(1)
    end
  end
end
