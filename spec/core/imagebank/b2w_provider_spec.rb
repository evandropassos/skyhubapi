require 'rails_helper'

describe "ImageBank - B2w provider"  do
  before do

    @imagebank = ImageBank::Client.new(ImageBank::Providers::B2w.new("http://54.152.221.29/images.json"))

  end

  context "fetch" do
    it 'return 10 images' do
      result = @imagebank.fetch

      expect(result.length).to eq(10)
    end
  end
end
