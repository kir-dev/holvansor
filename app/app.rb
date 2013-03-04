# encoding: UTF-8

require "rubygems"
require "bundler/setup"
require "sinatra"
require "slim"
require "sinatra/reloader" if development?
require "securerandom"

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
  if Beer.where(room: params[:room]).empty?
    @token = SecureRandom.hex
    Beer.create :room => params[:room], token: @token
  else
    @error = "A #{params[:room]} szobában már van sör."
    halt slim(:add_beer, layout: :form_layout)
  end
  slim :add_done, layout: :form_layout
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
