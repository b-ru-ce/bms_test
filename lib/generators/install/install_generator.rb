class InstallGenerator < Rails::Generators::Base

  def base_prepare
    gem 'haml-rails'
    gem 'rails_admin'
    gem "cancan"
    run('bundle install')
    generate "rails_admin:install"
    #if yes?("Would you like to install Haml?")
  end

  #install_haml if yes?('Install haml?')

end
