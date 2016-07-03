require 'sinatra'
require 'json'

class App < Sinatra::Base
  post '/gem/update' do
    # Grab our list of plugins
    plugin_json = File.read('../plugins-search-generated.json')
    plugins = JSON.parse(plugin_json)
    plugin_urls = plugins['plugins'].map { |plugin| plugin['url'] }

    request.body.rewind
    payload_body = request.body.read
    hook = JSON.parse(payload_body)

    # 403 if the webhook's repo isn't in the plugins search JSON
    source = hook['html_url']
    halt 403 unless plugin_urls.include? source

    travis_token = ENV['TRAVIS_TOKEN']
    body = '{ "request": { "branch":"master"} }'

    require 'net/http'
    require 'uri'

    # See https://docs.travis-ci.com/user/triggering-builds/
    # Triggers a build on travis
    uri = URI.parse('https://api.travis-ci.org/repo/danger%2Fdanger.systems/requests')
    header = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json',
      'Travis-API-Version' => '3',
      'Authorization' => "token #{travis_token}"
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body
    response = http.request(request)
    response.body
  end
end
