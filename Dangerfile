
# When someone offers a new plugin, we need to be able to discuss
# what the plugin will look like on the website. This gives us the chance
# to lint the documentation, and to ensure that some effort has been put in.

require 'json'

diff = git.diff_for_file("plugins.json")
if diff
  current_plugins = JSON.parse(diff.blob(:dst).contents)
  pr_plugins = JSON.parse(diff.blob(:src).contents)

  new_plugins = current_plugins - pr_plugins
  new_plugins.each do |plugin|
    overview = `bundle exec danger plugins readme #{plugin}`
    markdown "### Failed to parse #{plugin} showing error:" unless $?.success?
    markdown overview
    markdown "\n\n ---\n"
  end
end

if danger.scm_provider == :github
  warn("danger.systems has moved📦. The repo is now on [GitLab](https://gitlab.com/danger-systems/danger.systems). Please open an MR for that repo")
end
