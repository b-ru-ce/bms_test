class InstallGenerator < Rails::Generators::Base

  def install_haml
    gem 'haml-rails' if yes?("Would you like to install Haml?")
    gem 'rails_admin'
    gem "cancan"
    run('bundle install')
  end

  #install_haml if yes?('Install haml?')

end
