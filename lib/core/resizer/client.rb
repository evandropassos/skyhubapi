class Resizer::Client
  def initialize(provider)
    @provider = provider
  end

  def download(url_image, dest_file)
    @provider.download(url_image, dest_file)
  end

  def resize(origin_image, dest_image, width, height)
    @provider.resize(origin_image, dest_image, width, height)
  end

  def get_dimensions_size(size)
    @provider.get_dimensions_size(size)
  end

  def new_filename
    @provider.new_filename
  end

  def check_directory(directory)
    @provider.check_directory(directory)
  end

  def get_extension(file_name)
    @provider.get_extension(file_name)
  end

  def get_extension_by_url(url_image)
    @provider.get_extension_by_url(url_image)
  end

  def exists?(path_file)
    @provider.exists?(path_file)
  end
end
