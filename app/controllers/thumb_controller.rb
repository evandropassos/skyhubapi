class ThumbController < ApplicationController
  attr_accessor :bootstrapp
  
  def index
    result = @bootstrapp.thum_render_service.render(params)

    send_file result, { :type => MIME::Types.type_for(result), :disposition => 'inline' }
  end
end
