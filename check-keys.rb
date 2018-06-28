require 'net/http'

RIAK_HTTP_HOST="http://localhost:8098"

bucket = ARGV[0]
filename = ARGV[1]

def check_for_keys file_path
  found = 0
  File.open(file_path, "r") do |f|
    f.each_line do |key|
      if has_riak_record?(key)
        found += 1
      else
        puts key
      end
    end
  end
  found
end

def has_riak_record? key
  riak_bucket_path = "/buckets/#{ARGV[0]}/keys/"
  uri = URI(RIAK_HTTP_HOST + riak_bucket_path + key)
  res = Net::HTTP.get_response(uri)
  res.code.to_i == 200
end


if ! File.exist?(filename)
  puts "You must specify an existing filename. Could not find: #{filename}"
  exit 2
end

total = line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
found_count = check_for_keys(filename)
puts "found #{found_count} keys, out of #{total} total: #{(found_count.to_f / total.to_f) * 100}%"
