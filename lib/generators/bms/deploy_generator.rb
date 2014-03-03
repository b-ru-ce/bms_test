require 'rails/generators'

module Bms
  class DeployGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def deploy

      gsub_file 'Gemfile', "gem 'bms'", "#gem 'bms'"
      run('bundle install')

      gsub_file 'config/environments/production.rb', "config.assets.compile = false", "config.assets.compile = true"

      capify!

      copy_file 'Capfile', 'Capfile', force: true
      copy_file 'config/deploy.rb', 'config/deploy.rb', force: true

      git add: "."
      git commit: "-m Commit before deploy"

      run('cap deploy:first_setup')
      run('cap deploy:change_host_file')
      run('cap deploy')

    end



  end

end
