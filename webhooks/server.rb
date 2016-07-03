require 'sinatra'
require 'json'

class App < Sinatra::Base
  post 'gem/update' do
    request.body.rewind
    payload_body = request.body.read
    push = JSON.parse(payload_body)
    puts payload_body
  end
end
