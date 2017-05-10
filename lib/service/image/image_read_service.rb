class Service::Image::ImageReadService

  def total
    Image.count
  end

  def list
    Image.all
  end
end
