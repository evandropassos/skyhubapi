module ImageBank
  module Providers
  end
end

require_relative '../response/response.rb'
Dir[File.dirname(__FILE__) + '/**/*.rb'].each { |file| require file }
