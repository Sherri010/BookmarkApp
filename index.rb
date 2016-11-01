#https://www.safaribooksonline.com/library/view/seven-web-frameworks/9781941222676/f_0016.html

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

## Seeds

mark1 = Bookmark.new url:"http://google.com",title:"search"
mark1.save

mark2 = Bookmark.new url:"https://github.com/sherri010",title:"mygitub"
mark2.save

mark3 = Bookmark.new url:"http://niche-mapper.com",title:"work"
mark3.save

class Hash
   def slice(*whitelist)
    whitelist.inject({}) {|result,key| result.merge(key => self[key])}
   end
end

helpers do
   def h(text)
     Rack::Utils.escape_html(text)
   end
 end

def get_all_bookmarks
   Bookmark.all()
end

# #root
get "/" do
   erb :index
end
# #Index
get "/bookmarks" do
   # content_type :json
   @all_bookmarks = get_all_bookmarks
   erb :list
end
# #show
get "/bookmarks/:id" do
   id=params[:id]
   bookmark = Bookmark.get(id)
   content_type :json
   bookmark.to_json
end

# #create
post "/bookmarks" do
  input = params.slice "url","title"
  bookmark = Bookmark.create input
  redirect "/bookmarks"
end

# #update
put "/bookmarks/:id" do
  id= params[:id]
  bookmark = Bookmark.get(id)
  input = params.slice "url","title"
  bookmark.update input

end

# #destroy
delete "/bookmarks/:id" do
  id = params[:id]
  bookmark = Bookmark.get(id)
  bookmark.destroy

end