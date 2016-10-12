# curl2ruby
Convert Curl command line to Ruby code

```shell
# From chrome
$ curl 'http://www.phrack.org/' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, sdch'\
      -H 'Accept-Language: en-US,en;q=0.8,de;q=0.6,ro;q=0.4'\
      -H 'Upgrade-Insecure-Requests: 1'\
      -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'\
      -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'\
      -H 'Cache-Control: no-cache'\
      -H 'Connection: keep-alive'\
      --compressed

# Passed as args
$ curl2ruby curl 'http://www.phrack.org/' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, sdch'\
      -H 'Accept-Language: en-US,en;q=0.8,de;q=0.6,ro;q=0.4'\
      -H 'Upgrade-Insecure-Requests: 1'\
      -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'\
      -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'\
      -H 'Cache-Control: no-cache'\
      -H 'Connection: keep-alive'\
      --compressed

# Output
require 'uri'
require 'net/http'
require 'openssl'

uri = URI.parse('http://www.phrack.org/:80')
http = Net::HTTP.new(uri.host, uri.port)


req = Net::HTTP::Get.new(uri.path)

req.add_field('Pragma', 'no-cache')
req.add_field('Accept-Encoding', 'gzip, deflate, sdch')
req.add_field('Accept-Language', 'en-US,en;q=0.8,de;q=0.6,ro;q=0.4')
req.add_field('Upgrade-Insecure-Requests', '1')
req.add_field('User-Agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36')
req.add_field('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8')
req.add_field('Cache-Control', 'no-cache')
req.add_field('Connection', 'keep-alive')
resp = http.request(req)
puts resp.body
```

