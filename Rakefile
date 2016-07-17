require 'middleman-gh-pages'

task :generate do
  require 'json'
  require 'bundler'

  # Make sure we have a folder for json_data, it's not in git.
  Dir.mkdir('static/json_data') unless Dir.exist?('static/json_data')

  # Grab the Danger gem, pull out the file paths for the core plugins
  danger_gem = Gem::Specification.find_by_name "danger"
  danger_core_plugins = Dir.glob(danger_gem.gem_dir + "/lib/danger/danger_core/plugins/*.rb")

  # Document them, move them into a nice JSON file
  output = `bundle exec danger plugins json #{danger_core_plugins.join(' ')}`
  abort("Could not generate the core plugin metadata") if output.empty?
  File.write('static/json_data/core.json', output)
  puts 'Generated core API metadata'

  # Grab our definitive plugins list
  plugins = JSON.parse(File.read('plugins.json'))

  # Generate the Website's plugin doc, by passing in the gem names
  output = `bundle exec danger plugins json #{plugins.join(' ')}`
  abort("Could not generate any plugin metadata") if output.empty?
  File.write('static/json_data/plugins.json', output)
  puts 'Generated plugin metadata'

  # Generate the search plugin JSON file, this used by `danger plugins search`
  # and by the re-deploy webhook system.
  Bundler.with_clean_env do
    Dir.mktmpdir do |dir|
      Dir.chdir dir do
        gemfile = File.new("Gemfile", "w")
        gemfile.write "source 'https://rubygems.org'\n"
        
        plugins.each do |plugin|
          gemfile.write "gem '#{plugin}'\n"
        end
        gemfile.close

        sh "bundle install --path vendor/gems"

        spec_paths = plugins.flat_map { |plugin| Dir.glob("vendor/gems/ruby/*/specifications/#{plugin}*.gemspec").first }
        real_gems = spec_paths.map { |path| Gem::Specification.load path }

        plugin_metadata = real_gems.map do |gem|
          {
            gem: gem.name,
            authors: gem.authors.join(', '),
            url: gem.homepage,
            description: gem.summary,
            license: gem.license || 'Unknown',
            version: gem.version.to_s
          }
        end

        plugin_json = { plugins: plugin_metadata }
        plugins_file_path = File.join File.dirname(__FILE__), 'plugins-search-generated.json'
        File.write(plugins_file_path, plugin_json.to_json)
        puts 'Generated search metadata'
      end
    end
  end
end

desc 'Runs the site locally'
task :serve do
  puts 'Running locally at http://localhost:4567'
  sh 'open http://localhost:4567'
  Dir.chdir('static') do
    sh 'bundle exec middleman server'
  end
end
