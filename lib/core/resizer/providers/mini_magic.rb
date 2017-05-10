require 'fileutils'
require 'find'

class Resizer::Providers::MiniMagic
  attr_accessor :_path_destination, :_quality

  def initialize(path_destination, quality)
    self._path_destination = path_destination
    self._quality = quality
  end

  def download(url_image)
    if url_image.blank?
      raise ArgumentError, "url_image is not defined"
    end

    extension = get_extension(File.basename(URI.parse(url_image).path))
    new_image_name = "#{new_filename}#{extension}"
    new_image_path = File.join(self._path_destination, new_image_name)

    img = MiniMagick::Image::open(url_image)

    img.write(new_image_path) do
      self.quality = self._quality
    end

    new_image_path
  end

  def resize(src_image, size)
    image = MiniMagick::Image.new(src_image)

    dimensions = get_dimensions_size(size)
    extension = get_extension(src_image)
    new_image_name = "#{new_filename}#{dimensions}#{extension}"
    new_image_path = File.join(self._path_destination, new_image_name)

    image.resize = dimensions
    image.write new_image_path
  end

  def get_dimensions_size(size)
    dimensions = ""
    if size == :small
      dimensions = "320x240"
    elsif size == :medium
      dimensions = "384x288"
    elsif size == :large
      dimensions = "640x480"
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

  def exists?(path_file)
    File.exists?(path_file)
  end

end
