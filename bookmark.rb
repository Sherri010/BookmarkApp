require "data_mapper"
# #creating a resource
class Bookmark
  #model is going to need to be persistent, so we'll include DataMapper::Resource.
  include DataMapper::Resource
   property :id,Serial
   property :url,String
   property :title,String
end
