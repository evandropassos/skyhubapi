class Image
  include Mongoid::Document

  store_in collection: 'images'
  
  field :url, :type => String
  field :formats, :type => Array
end
