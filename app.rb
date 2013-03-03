# encoding: UTF-8

require "rubygems"
require "bundler/setup"
require "sinatra"
require "slim"
require "sinatra/reloader" if development?
require "securerandom"

# require app parts
$:.unshift File.dirname(__FILE__)

require "config/db"

configure do
  set :views, File.join(File.dirname(__FILE__), "app","views")
  set :public_folder, File.join(File.dirname(__FILE__), "app", "assets")
end

get "/" do
  if not beer.empty?
    ids = beer.map(:id)
    id = ids[Random.rand(ids.size)]
    @room = beer.first(id: id)[:room]
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
  if beer.where(room: params[:room]).empty?
    @token = SecureRandom.hex
    beer.insert :room => params[:room], token: @token
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
  b = beer.first room: params[:room]
  if b && b[:token] == params[:token]
    beer.where(:id => b[:id]).delete
    redirect to("/")
  else
    @error = "Nem sikerült kitörölni."
    slim :remove_beer, layout: :form_layout
  end
end

get "/faq" do
  slim :faq
end

def beer
  DB[:beer]
end
