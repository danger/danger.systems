require 'middleman-gh-pages'

task :generate do
  require 'json'
  plugins = JSON.parse(File.read 'plugins.json')
  output = `bundle exec danger plugin lint #{plugins.join(' ')}`
  File.write('static/json_data/plugins.json', output)
end
