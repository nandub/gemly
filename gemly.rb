require_relative 'main'

class Gemly < OpenStruct
  APIURL = 'http://rubygems.org/api/v1/gems/'

  def self.parse(raw)
    gemly = new pull_spec_from raw
    puts "#{gemly.name} was retrieved!"
  end

  def self.pull_spec_from(raw)
    name = raw.split.first
    url = APIURL + name + '.json'
    body = Curl::Easy.http_get(url).body_str
    @spec = Yajl::Parser.parse body, symbolize_keys: true
  end

  def self.attributes
    marshal_dump
  end
end
