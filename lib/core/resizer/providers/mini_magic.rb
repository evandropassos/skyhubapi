require 'fileutils'
require 'find'

class Resizer::Providers::MiniMagic
  attr_accessor :_path_destination, :_quality

  def initialize(quality)
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
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten
    new_file_name  =  (0..15).map{ o[rand(o.length)]  }.join
    return new_file_name
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
    if origin_image.blank?
      raise ArgumentError, "origin_image is not defined"
    end

    if dest_image.blank?
      raise ArgumentError, "dest_image is not defined"
    end

    if width.nil?
      raise ArgumentError, "width is not defined"
    end

    if height.nil?
      raise ArgumentError, "height is not defined"
    end

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

  def download(url_image, dest_file)
    if url_image.blank?
      raise ArgumentError, "url_image is not defined"
    end

    if dest_file.blank?
      raise ArgumentError, "dest_file is not defined"
    end

    img = MiniMagick::Image::open(url_image)

    img.write(dest_file) do
      self.quality = self._quality
    end

    dest_file
  end

end
