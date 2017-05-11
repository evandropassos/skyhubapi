class Service::ThumbService::ThumbRenderService

  def initialize(resizer_client, path_thumbs, path_tmps)
    @resizer_client = resizer_client
    @path_thumbs = path_thumbs
    @path_tmps = path_tmps
  end

  def render(params)
    width = 0
    height = 0
    filename = ""

    if not params[:width].nil?
      width = params[:width].to_i
    end

    if not params[:height].nil?
      height = params[:height].to_i
    end

    filename = params[:filename]
    extension = params[:extension]
    full_filename = "#{filename}.#{extension}"

    path = File.join(@path_thumbs,width.to_s, height.to_s)
    path_filename =  File.join(path, full_filename)

    if not @resizer_client.exists?(path_filename)

      @resizer_client.check_directory(path)
      @resizer_client.check_directory(@path_tmps)

      image_db = Image.where(id: filename).first
      if image_db.nil?
        raise ArgumentError, "file not exists"
      end

      tmp_file = File.join(@path_tmps, full_filename)

      if not @resizer_client.exists?(tmp_file)
        @resizer_client.download(image_db.origin_url, tmp_file)
      end

      @resizer_client.resize(tmp_file, path_filename, width, height)
    end

    path_filename
  end
end
