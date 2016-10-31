require "data_mapper"
# #creating a resource
class Bookmark
  include DataMapper::Resource
   property :id,Serial
   property :url,String
   property :title,String
end
