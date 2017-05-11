require File.join(Rails.root, "lib/bootstrapper")

class ApplicationController < ActionController::API

  def initialize
    super

    @bootstrapp = Skyhubapi::Bootstrapper.new
  end
end
