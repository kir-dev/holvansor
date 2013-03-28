# encoding: UTF-8

require "rubygems"
require "bundler/setup"
require "sinatra"
require "slim"
require "pony"

if development?
  require "sinatra/reloader"
  also_reload "app/models/beer.rb"
end

configure :production do
  Dir.mkdir "log" unless File.exists? "log"
  LOG_PATH = "log/#{settings.environment}.log"

  log_file = File.new(LOG_PATH, "a+")
  $stdout.reopen(log_file)
  $stderr.reopen(log_file)

  $stdout.sync = true
  $stderr.sync = true
end

# require app parts
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), ".."))

require "config/db"
require "config/mail"
require "app/models/beer"

configure do
  set :app_file, __FILE__
  disable :run
  enable :logging, :dump_erros
  set :public_folder, File.join(File.dirname(__FILE__), "assets")
end

configure :development do
  set :raise_errors, true
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
  logger.info "Trying to add a room (#{params[:room]}) from #{request.ip}"
  b = Beer.new :room => params[:room].to_i, :email => params[:email]
  email_given = !params[:email].nil? && !params[:email].empty?

  if b.save && email_given
    # all done
    @token = b.token
    @email = params[:email]
    Thread.new { mail @email, @token, b.room }
    slim :add_done, layout: :form_layout
  else
    # validation error
    @error = b.errors.map { |_,msg| msg.join }
    @error << "Nem adtál meg email címet!" unless email_given
    slim :add_beer, layout: :form_layout
  end
end

get "/remove" do
  slim :remove_beer, layout: :form_layout
end

delete "/remove" do
  b = Beer.first room: params[:room].to_i
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

get "/confirm/:token" do
  b = Beer.first token: params[:token]
  if b
    b.marked_for_deletion = false
    b.save

    "Köszi! A megerősítése sikeres volt a #{b.room} szobához."
  else
    "Érvénytelen token."
  end
end

# error pages
error { slim :'500', layout: false } 
not_found { slim :'404', layout: false } 

# helper methods

def mail(to, token, room)
  return if test? # do not send emails while testing

  $message ||= File.read("#{settings.root}/emails/token.txt")
  
  body = $message % [room, token, to("/remove")]
  Pony.mail to: to, subject: "holvansör token a #{room} szobához", body: body
end