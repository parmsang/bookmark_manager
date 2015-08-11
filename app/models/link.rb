# This class corresponds to a table in the database
# We can use it to manipulate the data
#require 'sinatra/base'

class Link #< Sinatra::Base

  # adds datamapper functionality to this class
  include DataMapper::Resource

  # these property declarations set the column headers in the Link table
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :title,  String
  property :url,    String

end
