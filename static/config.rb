require 'json'
# Create some pages that represent the plugins
plugins = JSON.parse(File.read('json_data/plugins.json'))
plugins.each do |plugin|
  html_path = "/plugins/#{plugin['instance_name']}.html"
  inline_path = "/plugins/#{plugin['instance_name']}_embed.html"
  template = '/plugins/template.html'
  proxy html_path, template, locals: { plugin: plugin }, ignore: true
  proxy inline_path, template, locals: { plugin: plugin }, ignore: true, layout: false
end

configure :development do
  activate :livereload
end

require 'lib/add_links_to_headers.rb'
activate :add_links_to_headers

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown, autolink: true, space_after_headers: true,
               no_intra_emphasis: true, tables: true, with_toc_data: true,
               fenced_code_blocks: true, smartypants: true

require 'lib/html_helpers.rb'
helpers HTMLHelpers

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :asset_hash
end
