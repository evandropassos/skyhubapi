class Resizer::Client
  def initialize(provider)
    @provider = provider
  end

  def download(url_image)
    @provider.download(url_image)
  end

  def resize(src_image)
    @provider.resize(src_image)
  end
end
