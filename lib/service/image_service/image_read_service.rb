class Service::ImageService::ImageReadService

  def total
    Image.all.count
  end

  def list
    Image.all
  end
end
