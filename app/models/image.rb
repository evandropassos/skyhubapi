class Image
  include Mongoid::Document

  store_in collection: 'images'

  field :origin_url, :type => String
  field :formats, :type => Array
end
