require 'net/http'
require 'uri'
require 'json'

# how to use:
# request = RestClientCall.new
# request.<rest_method>(endpoint, params, :header => {})
# :header is optional, if not any specified, defauld will be used.

class RestClientCall

  REST_METHODS = %w[get delete post put patch]
  private_constant :REST_METHODS

  REST_METHODS.each do |method|
    define_method(method) do |endpoint, params, options = {}|
      uri = URI.parse(endpoint)
      header = default_header.merge(options[:header] || {})

      net_req = Object.const_get("Net::HTTP::#{method.capitalize}").new(uri.request_uri)
      net_req.body = JSON.generate(params) unless params == nil
      response_time, response = nil, nil
      begin
        response_time = Benchmark.realtime do
          response = http(uri).request(req_builder(net_req, header))
        end
        puts "Request uri: #{uri}"
        puts "Response time: #{response_time}"
      rescue Exception => e
        response = e.response
      end
      response
    end
  end

  def req_builder(net_req, header)
    header.each { |key, value| net_req[key] = value }
    net_req
  end

  def http(uri)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https', verify_ssl: false)
  end

  def default_header
    # if not any provided default header will be used
    # any extra params will be merged...
    {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
  end

end