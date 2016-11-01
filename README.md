## About Sinatra Framework
![](http://ddi-dev.com/uploads/media/news/0001/01/thumb_505_news_main.jpeg)

Sinatra is a lightweight and simple framework, allowing you to write a web application with the least possible amount of code. It's an open-source and domain-specific language writen in Ruby. Sinatra is a very lightweight framework with few dependencies. Getting started and developing an application are effortless. All you need is to install the gem and require it:

` gem install sinatra `
```
require "sinatra"

get "/hello" do	
  "Hello, Sinatra"	
end
```

Sinatra is great for creating RESTful applications and APIs and provides lots of options for developer to choose from. You can use mix Sinatra with AngularJS or other front-end frameworks or use it alone to create front end. You can use PostgreSQL or SQLite with ActiveRecord, DataMapper or etc for ORM. DataMApper is used in this example which is an Object Relational Mapper in Ruby.


###Sinatra vs Rails
- Sinatra is tiny.It's around 1500 lines of code. Rails is closer to 100,000 lines of code. That's almost 1/100th the size of Rails.
- Rails makes assumptions and takes care of alot for developers, Sinatra provides minimum amount of tools and lets the developer architect everything.
- Rails is a framework focused on writing model driven web applications, Sinatra is a library for dealing with HTTP from the server side. 
- Rails is good for large applications, Sinatra works great for small apps and APIs.
- Rails has a larger community 


##Bookmark example:

#### Requirements:
```
#server.rb

require "sinatra"
require "data_mapper"
require "dm-core"
require "dm-timestamps"
require "dm-validations"
require "dm-validations"
require_relative "bookmark"
require"dm-serializer"

```

#### Model and DB:
- model:
```
#bookmark.rb

require "data_mapper"

class Bookmark
  include DataMapper::Resource
   property :id,Serial
   property :url,String
   property :title,String
end
```

```
#server.rb

DataMapper.setup(:default,"sqlite3://#{Dir.pwd}/bookmakrs.db")
DataMapper.auto_migrate!
DataMapper.auto_upgrade!

```

Creates bookmark.db


```
#server.rb


def get_all_bookmarks
   Bookmark.all()
end


##root
get "/" do
   erb :index  #**
end

##Index
get "/bookmarks" do
   @all_bookmarks = get_all_bookmarks
   erb :list #**
end

##show
get "/bookmarks/:id" do
   id=params[:id]
   bookmark = Bookmark.get(id)
   content_type :json
   bookmark.to_json #**
end

```

####Views
view for index rout:

```
<div id="wrapper">
<ul>
  <% @all_bookmarks.each do |mark| %>
   <li>
     <div>
         <h3> <%= mark.title %> </h3>
         <a href="<%= mark.url %>" target="blank"> visit page</a>
         <button id="<%= mark.id%>" class="remove">X</button>
      </div>
    </li>
  <% end %>
</ul>
</div>
```

#### Other routes:

```
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
```


Sources:
- Sinatra docs   : http://www.sinatrarb.com/
- Source code    : https://github.com/sinatra/sinatra
- DataMapper doc : http://datamapper.org/
- Example ref    : Seven Web Frameworks in Seven Weeks by Jack Moffitt, Fred Daoud 

![](https://camo.githubusercontent.com/98a445316eacd837aedabadf1050fcc5246434c5/687474703a2f2f7777772e617070656c7369696e692e6e65742f6173736574732f73696e617472612d6c6f676f2e676966)


