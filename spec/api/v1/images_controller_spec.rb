require 'rails_helper'

describe Api::V1::ImagesController, :type => :controller  do
  it 'populate images by endpoint' do
    expect(@controller.bootstrapp.image_write_service).to receive(:populate_images)
    get :index

  end

  it 'return mongo data' do
    expect(@controller.bootstrapp.image_write_service).not_to receive(:populate_images)
    create(:basic_image)

    get :index

  end

  it 'list 10 images' do
    get :index

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["images"].length).to eq(10)
  end
end
