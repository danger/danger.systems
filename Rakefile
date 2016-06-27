require 'middleman-gh-pages'

desc "Runs the site locally"
task :serve do
  puts 'Running locally at http://localhost:4567'
  sh "open http://localhost:4567"
  Dir.chdir 'static' do
    sh "bundle exec middleman server"
  end
end

task :generate do
  require 'json'
  plugins = JSON.parse(File.read "plugins.json")
  output = `bundle exec danger plugin lint #{plugins.join(" ")}`
  File.write("static/json_data/plugins.json", output)
end


desc "Ship to github pages"
# begin
  desc 'Build and push the guides to GitHub Pages'
  task :deploy do
    Rake::Task['generate'].invoke
    system("rake publish PROJECT_ROOT='static'")
  end
# # rescue LoadError => e
#   $stderr.puts "[!] Disabled the middleman publish task, run `bundle exec` first."
# end
