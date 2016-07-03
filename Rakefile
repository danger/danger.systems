require 'middleman-gh-pages'

task :generate do
  require 'json'
  plugins = JSON.parse(File.read('plugins.json'))
  output = `bundle exec danger plugin lint #{plugins.join(' ')}`
  Dir.mkdir('static/json_data') unless Dir.exist?('static/json_data')
  File.write('static/json_data/plugins.json', output)
  puts "OK"
end


desc 'Runs the site locally'
task :serve do
  puts 'Running locally at http://localhost:4567'
  sh 'open http://localhost:4567'
  Dir.chdir('static') do
	sh 'bundle exec middleman server'
  end
end

