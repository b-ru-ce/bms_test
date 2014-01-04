def install_haml
  gem 'haml-rails'
  run('bundle install')
end

install_haml if yes?('Install haml?')