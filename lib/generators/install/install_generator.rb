class InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def base_prepare
    gem 'haml-rails'
    gem 'html2haml'
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
      #gem 'annotate', git: 'git://github.com/jeremyolliver/annotate_models.git', branch: 'rake_compatibility'
      gem 'annotate'
      gem 'populator'
      gem 'faker'
    end
    run('bundle install')

    generate 'kaminari:views', 'default'
    generate 'devise:views'

    run('for file in app/views/devise/**/*.erb; do html2haml -e $file ${file%erb}haml && rm $file; done')

    generate 'model', 'MyConfig key:string key_ru:srting value:text'
    generate 'model', 'Role name:string'
    generate 'migration', 'AddRoleIdToUsers role_id:integer'
    rake 'db:migrate'

    copy_file 'app/models/ability.rb', 'app/models/ability.rb'
    copy_file 'app/models/my_config.rb', 'app/models/my_config.rb'
    copy_file 'app/models/role.rb', 'app/models/role.rb'
    copy_file 'app/models/user.rb', 'app/models/user.rb'

    copy_file 'tasks/base_fill.rake', 'lib/tasks/base_fill.rake'
    rake 'db:fill_my_config'
    rake 'db:fill_users'

    #if yes?("Would you like to install Haml?")
  end



end
