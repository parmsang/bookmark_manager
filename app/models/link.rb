require "data_mapper"

class Link

  # adds datamapper functionality to this class
  include DataMapper::Resource

  # these property declarations set the column headers in the Link table
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :title,  String
  property :url,    String
  property :tag,    String
  has n, :tags, through: Resource

end
