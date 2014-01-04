class InstallGenerator < Rails::Generators::Base

  def base_prepare
    gem 'haml-rails'
    gem 'rails_admin'
    gem 'cancan'
    run('bundle install')

    generate 'rails_admin:install'
    rake 'db:migrate'

    gem 'dragonfly', '~> 1.0.0'
    gem 'ckeditor'
    run('bundle install')

    generate 'dragonfly'
    gem 'paperclip'
    run('bundle install')

    generate 'ckeditor:install', '--orm=active_record --backend=paperclip'
    rake 'db:migrate'

    generate 'cancan:ability'

    gem_group :development do
      gem 'annotate'
      gem 'populator'
      gem 'faker'
    end
    run('bundle install')

    generate 'kaminari:views', 'default'
    generate 'devise:views'

    run('for file in app/views/devise/**/*.erb; do html2haml -e $file ${file%erb}haml && rm $file; done')

    #if yes?("Would you like to install Haml?")
  end

  #install_haml if yes?('Install haml?')

end
