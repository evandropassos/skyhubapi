require 'fileutils'
require 'find'

class Resizer::Providers::MiniMagic
  attr_accessor :_path_destination, :_quality

  def initialize(path_destination, quality)
    self._path_destination = path_destination
    self._quality = quality
  end

  def get_dimensions_size(size)
    dimensions = nil
    if size == :small
      dimensions = { w: 230, h: 240 }
    elsif size == :medium
      dimensions = { w: 384, h: 288 }
    elsif size == :large
      dimensions = { w: 640, h: 480 }
    else
      raise ArgumentError, "size is not supported"
    end

    dimensions
  end

  def new_filename
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;
    new_file_name  =  (0..15).map{ o[rand(o.length)]  }.join;
    return new_file_name;
  end

  def get_extension(file_name)
    File.extname(file_name)
  end

  def get_extension_by_url(url_image)
    File.extname(File.basename(URI.parse(url_image).path))
  end

  def exists?(path_file)
    File.exists?(path_file)
  end


  def resize(origin_image, dest_image, width, height)
    image = MiniMagick::Image::open(origin_image)

    dimensions = "#{width}x#{height}"

    image.resize  dimensions
    image.write dest_image
  end

  def check_directory(directory)
    if not File.directory?(directory)
      FileUtils.mkdir_p(directory)
    end
  end

  def download(url_image)
    if url_image.blank?
      raise ArgumentError, "url_image is not defined"
    end

    check_directory(self._path_destination)

    extension = get_extension_by_url(url_image)
    new_image_name = "#{new_filename}#{extension}"
    new_image_path = File.join(self._path_destination, new_image_name)

    img = MiniMagick::Image::open(url_image)

    img.write(new_image_path) do
      self.quality = self._quality
    end

    new_image_path
  end

end
