require "yaml"

config_dir = File.dirname(__FILE__)

config_path = File.join(config_dir, "config.yml")

if File.exists? config_path
  conf = YAML.load_file config_path
  ENV['DATABASE_URI'] ||= conf["db_uri"]
  ENV['HOST'] ||= conf["host"]
end

