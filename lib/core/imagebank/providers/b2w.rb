class ImageBank::Providers::B2w

  def initialize(source_url)
    @source_url = source_url
  end

  def fetch
    response = RestClient::Request.execute(method: :get, url: @source_url)
    convert_response(JSON.parse(response.body))
  end

  def convert_response(data)
    response = nil
    result = []
    data["images"].each do |item|
      response = ImageBank::Response::ImageResponse.new
      response.url = item["url"]
      result << response
    end

    result
  end
end
