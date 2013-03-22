require "pony"

def symbolize_keys(hash)
  result = {}
  hash.each do |k,v|
    value = v
    value = symbolize_keys(v) if v.is_a? Hash
    result.merge! k.to_sym => value
  end
  result
end

mail_config = File.dirname(__FILE__)

Pony.options = symbolize_keys YAML.load_file(File.join(mail_config, "mail.yml"))