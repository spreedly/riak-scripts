require 'net/http'
require 'uri'

RIAK_HTTP_HOST="http://localhost:8098"
RIAK_BUCKET_PATH = "/buckets/test-repl-trace/keys/"
RECORD_COUNT = 50
RECORD_INTERVAL = 5

def create_timestamp
  t = Time.new
  key = t.strftime("%H:%M:%S.%N-#{t.to_i}")
  p key
  key
end

def create_record
  key = create_timestamp

  uri = URI(RIAK_HTTP_HOST + RIAK_BUCKET_PATH + key)
  request = Net::HTTP::Put.new(uri)
  request.content_type = "text/plain"
  request.body = Time.new.to_s

  response = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end
  # response.code
  # response.body
end

RECORD_COUNT.times do
  create_record
  sleep RECORD_INTERVAL
end
