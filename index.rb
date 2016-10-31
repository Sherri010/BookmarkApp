require "sinatra"
require "data_mapper"
require "dm-core"
require "dm-timestamps"
require "dm-validations"
require "dm-validations"
require_relative "bookmark"
require"dm-serializer"

DataMapper.setup(:default,"sqlite3://#{Dir.pwd}/bookmakrs.db")
DataMapper.auto_migrate!
DataMapper.auto_upgrade!

class Hash
   def slice(*whitelist)
    whitelist.inject({}) {|result,key| result.merge(key => self[key])}
   end
end

def get_all_bookmarks
   Bookmark.all(:order => :title)
end

# #Index
get "/bookmarks" do
   content_type :json
   get_all_bookmarks.to_json
end
# #show
get "/bookmarks/:id" do
   id=params[:id]
   bookmark = Bookmark.get(id)
   content_type :json
   bookmark.to_json
end

# #create
post "/bookmakrs" do
  input = params.slice "url","title"
  bookmark = Bookmark.create input
  [201,"/bookmarks/#{bookmark['id']}"]
end

# #update
put "/bookmarks/:id" do
  id= params[:id]
  bookmark = Bookmark.get(id)
  input = params.slice "url","title"
  bookmark.update input
  204
end

# #destroy
delete "/bookmarks/:id" do
  id = params[:id]
  bookmark = Bookmark.get(id)
  bookmark.destroy
  200
end