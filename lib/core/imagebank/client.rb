class ImageBank::Client
  def initialize(provider)
    @provider = provider
  end

  def fetch
    @provider.fetch
  end
end
