
# When someone offers a new plugin, we need to be able to discuss
# what the plugin will look like on the website. This gives us the chance
# to lint the documentation, and to ensure that some effort has been put in.

require 'json'
current_plugins = JSON.parse(`git show master:plugins.json`)
pr_plugins = JSON.parse(File.read("plugins.json"))

new_plugins = current_plugins - pr_plugins
new_plugins.each do |plugin|
  overview = `bundle exec danger plugins readme #{plugin}`
  markdown "### Failed to parse #{plugin}" if $0 != 0
  markdown overview
  markdown "\n\n ---\n"
end
