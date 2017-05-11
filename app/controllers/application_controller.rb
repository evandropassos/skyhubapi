require File.join(Rails.root, "lib/bootstrapper")

class ApplicationController < ActionController::API

  def initialize
    super

    @bootstrapp = Skyhubapi::Bootstrapper.new
  end

  rescue_from Exception do |exception|
		log_exception(exception)
    if exception.is_a? ArgumentError
      render json: { message: exception.message}, :status => 500
    else
      render json: { message: "An unexpected error"}, :status => 500
    end
	end


  def log_exception(exception)
		Rails.logger.error(exception)
		Rails.logger.error(exception.message)
		Rails.logger.error(exception.backtrace.join("\r\n"))
		Rails.logger.error(session.to_hash.class)
		Rails.logger.error(session.to_hash)
	end
end
