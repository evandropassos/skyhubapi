class Service::ImageService::ImageReadService

  def total
    Image.all.count
  end

  def list
    Image.all
  end

  def get_by_id(id)
    Image.where(id: id).first
  end
end
