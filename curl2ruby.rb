#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'
require 'uri'

prog_name = ARGV.shift(1)[0]
url = ARGV.shift(1)[0]
uri = URI.parse(url)

options = OpenStruct.new(
  http_method: "GET",
  headers: []
)

OptionParser.new do |o|
  o.on('-X method') { |val| options.http_method = val; }
  o.on('-H [a-z0-9:/]*') { |val| options.headers << val; }
  o.on('--data postdata') { |val| options.data = val; options.http_method = "POST" }
  o.on('--compressed') { |val| options.compressed = val }
end.parse!()

code = <<CODE

require 'uri'
require 'net/http'
require 'openssl'

uri = URI.parse('#{url}')
http = Net::HTTP.new(uri.host, uri.port)
#{uri.scheme == "https" ? "http.use_ssl = true; http.verify_mode = OpenSSL::SSL::VERIFY_NONE" : ""}

req = Net::HTTP::#{options.http_method.capitalize}.new(uri.path)
#{options.data ? "req.body = '#{options.data}'" : ""}
CODE

code += "{\n"
options.headers.each do |header|
  (name, value) = header.split(/:\s*/, 2)
  code += "\t'#{name}' => '#{value}',\n"
end
code += "}.each { |name, value| req.add_field(name, value) }\n"

code += "resp = http.request(req)\n"
code += "puts resp.body\n"

puts code


