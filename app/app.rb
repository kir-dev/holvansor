# encoding: UTF-8

require "rubygems"
require "bundler/setup"
require "sinatra"
require "slim"

if development?
  require "sinatra/reloader"
  also_reload "app/models/beer.rb"
end

# require app parts
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), ".."))

require "config/db"
require "app/models/beer"

configure do
  set :app_file, __FILE__
  # set :views, File.join(File.dirname(__FILE__), "app","views")
  set :public_folder, File.join(File.dirname(__FILE__), "assets")
end

get "/" do
  if not Beer.empty?
    ids = Beer.map(:id)
    id = ids[Random.rand(ids.size)]
    @room = Beer[id: id].room
  else
    @room = "nincs :'(" 
  end
  
  slim :home
end

get "/all" do
  slim :all
end

get "/add" do
  slim :add_beer, layout: :form_layout
end

post "/add" do
  b = Beer.new :room => params[:room].to_i
  if b.save
    # all done
    @token = b.token
    slim :add_done, layout: :form_layout
  else
    # validation error
    @error = b.errors
    slim :add_beer, layout: :form_layout
  end
end

get "/remove" do
  slim :remove_beer, layout: :form_layout
end

delete "/remove" do
  b = Beer.first room: params[:room]
  if b && b[:token] == params[:token]
    b.destroy
    redirect to("/")
  else
    @error = "Nem sikerült kitörölni."
    slim :remove_beer, layout: :form_layout
  end
end

get "/faq" do
  slim :faq
end
