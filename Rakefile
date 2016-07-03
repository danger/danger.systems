require 'middleman-gh-pages'

task :generate do
  require 'json'
  require 'bundler'
  plugins = JSON.parse(File.read('plugins.json'))

  # # Generate the Website's plugin stuff
  output = `bundle exec danger plugin lint #{plugins.join(' ')}`
  Dir.mkdir('static/json_data') unless Dir.exist?('static/json_data')
  File.write('static/json_data/plugins.json', output)
  puts 'Generated plugin metadata'

  # Generate the search query stuff
  Bundler.with_clean_env do
    Dir.mktmpdir do |dir|
      Dir.chdir dir do
        gem_names = plugins
        deps = gem_names.map { |name| Bundler::Dependency.new(name, '>= 0') }

        # Use Gems from rubygems.org
        source = Bundler::SourceList.new
        source.add_rubygems_remote('https://rubygems.org')

        # Create a definition to bundle, make sure it always updates
        # and uses the latest version from the server
        bundler = Bundler::Definition.new(nil, deps, source, true)
        specs = bundler.resolve_remotely!

        # Get the name'd gems out of bundler, then convert them into useful search metadata
        gem_paths = specs.select { |spec| spec.is_a? Bundler::EndpointSpecification }.map { |endpoint| endpoint.gem_dir + '/' + endpoint.name + '.gemspec' }
        real_gems = gem_paths.map { |path| Gem::Specification.load path }
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
