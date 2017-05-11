require 'rails_helper'

describe "Resizer - minimagic provider"  do
  before do

    @resizer_client = Resizer::Client.new(Resizer::Providers::MiniMagic.new(80))

    @dest_file = File.join(Rails.root, "spec", "test_files", "test1.jpg")

  end

  context "get_dimensions_size" do
    it 'and send small' do
      result = @resizer_client.get_dimensions_size(:small)
      expect(result[:w]).to eq(230)
      expect(result[:h]).to eq(240)
    end

    it 'and send medium' do
      result = @resizer_client.get_dimensions_size(:medium)
      expect(result[:w]).to eq(384)
      expect(result[:h]).to eq(288)
    end

    it 'and send large' do
      result = @resizer_client.get_dimensions_size(:large)
      expect(result[:w]).to eq(640)
      expect(result[:h]).to eq(480)
    end

    it 'and send size not supported' do
      expect {  @resizer_client.get_dimensions_size(:large1) }.to raise_error(ArgumentError, "size is not supported")
    end
  end

  context "download" do
    let(:url_image) { "http://54.152.221.29/images/b737_5.jpg" }


    it 'and not send url_image' do
      expect { @resizer_client.download("", @dest_file) }.to raise_error(ArgumentError, "url_image is not defined")
    end

    it 'and not send dest_file' do
      expect { @resizer_client.download(url_image, "") }.to raise_error(ArgumentError, "dest_file is not defined")
    end

    it 'and download success' do
      expect { @resizer_client.download(url_image, @dest_file) }.not_to raise_error
    end
  end

  context "resize" do
    let(:resize_image) { File.join(Rails.root, "spec", "test_files", "resize_image.jpg") }

    it 'and not send origin_image' do
      expect { @resizer_client.resize("", @dest_file, 200, 200) }.to raise_error(ArgumentError, "origin_image is not defined")
    end

    it 'and not send dest_image' do
      expect { @resizer_client.resize(resize_image, "", 200, 200) }.to raise_error(ArgumentError, "dest_image is not defined")
    end

    it 'and not send width' do
      expect { @resizer_client.resize(resize_image, @dest_file, nil, 200) }.to raise_error(ArgumentError, "width is not defined")
    end

    it 'and not send height' do
      expect { @resizer_client.resize(resize_image, @dest_file, 200, nil) }.to raise_error(ArgumentError, "height is not defined")
    end

    it 'and resize success' do
      expect { @resizer_client.resize(resize_image, @dest_file, 200, 200) }.not_to raise_error
    end
  end
end
