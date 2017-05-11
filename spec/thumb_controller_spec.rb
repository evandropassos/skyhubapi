require 'rails_helper'

describe ThumbController, :type => :controller  do
  before do
    @basic_image = create(:basic_image)
  end

  it 'render image' do

    get :index, { :params => { :width => 384, :height => 288, :filename => @basic_image._id, :extension => ".jpg" } }
    expect(response).to be_success
  end
end
