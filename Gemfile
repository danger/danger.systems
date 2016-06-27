# This Gemfile is used for the Rakefile, notably the `rake generate` task.
gem 'danger', git: 'https://github.com/danger/danger.git', branch: 'lint'

gem 'pry', '~> 0.10'
gem 'yard', '~> 0.8'

instance_eval File.read("static/Gemfile") if File.file? "static/Gemfile"
