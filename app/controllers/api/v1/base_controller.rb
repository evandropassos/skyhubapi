require File.join(Rails.root, "lib/bootstrapper")

class Api::V1::BaseController < ApplicationController
  def initialize
    super

    @bootstrapp = Skyhubapi::Bootstrapper.new
  end
end
