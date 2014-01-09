class InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def base_prepare
    #git :init
    #git add: '.'
    #git commit: '-m Init commit'

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

    #gem_group :development do
    #  #gem 'annotate', git: 'git://github.com/jeremyolliver/annotate_models.git', branch: 'rake_compatibility'
    #  gem 'annotate'
    #  gem 'populator'
    #  gem 'faker'
    #end
    #run('bundle install')
    #
    #generate 'kaminari:views', 'default'
    #generate 'devise:views'
    #
    #run('for file in app/views/devise/**/*.erb; do html2haml -e $file ${file%erb}haml && rm $file; done')
    #
    #generate 'model', 'MyConfig key:string key_ru:string value:text'
    #generate 'model', 'Role name:string'
    #generate 'migration', 'AddRoleIdToUsers role_id:integer'
    #rake 'db:migrate'
    #
    #copy_file 'app/models/ability.rb', 'app/models/ability.rb'
    #copy_file 'app/models/my_config.rb', 'app/models/my_config.rb'
    #copy_file 'app/models/role.rb', 'app/models/role.rb'
    #copy_file 'app/models/user.rb', 'app/models/user.rb'
    #
    #copy_file 'tasks/base_fill.rake', 'lib/tasks/base_fill.rake'
    #rake 'db:fill_my_config'
    #rake 'db:fill_users'

    copy_file 'config/initializers/rails_admin.rb', 'config/initializers/rails_admin.rb'
    #copy_file 'config/locales/ru.yml', 'config/locales/ru.yml'
    #copy_file 'config/locales/devise.ru.yml', 'config/locales/devise.ru.yml'
    #copy_file 'config/locales/rails_admin.ru.yml', 'config/locales/rails_admin.ru.yml'
    #copy_file 'config/locales/kaminary.yml', 'config/locales/kaminary.yml'
    #copy_file 'app/controllers/application_controller.rb', 'app/controllers/application_controller.rb'
    #copy_file 'app/helpers/application_helper.rb', 'app/helpers/application_helper.rb'
    #
    #application do
    #  "config.time_zone = 'Ekaterinburg'"
    #  "config.i18n.default_locale = :ru"
    #end

    #git add: '.'
    #git commit: '-m Base prepare completed'

  end

  def news
    if yes?('Would you like to install module News? (y/n)')
      #generate 'controller', 'Articles'
      #copy_file 'app/controllers/articles_controller.rb', 'app/controllers/articles_controller.rb'
      #
      #generate 'model', 'Article title:text date:date image_uid:string short_text:text text:text title_of_window:string'
      #rake 'db:migrate'
      #copy_file 'app/models/article.rb', 'app/models/article.rb'
      #
      #copy_file 'app/views/articles/_article.html.haml', 'app/views/articles/_article.html.haml'
      #copy_file 'app/views/articles/index.html.haml', 'app/views/articles/index.html.haml'
      #copy_file 'app/views/articles/show.html.haml', 'app/views/articles/show.html.haml'
      #route "get 'news' => 'articles#index'"
      #route "get 'articles/:id-:alias' => 'articles#show'"
      #
      #copy_file 'tasks/fill_news.rake', 'lib/tasks/fill_news.rake'
      #rake 'db:fill_news'

      insert_into_file 'config/initializers/rails_admin.rb', File.read('lib/generators/install/templates/config/initializers/_rails_admin_news.rb'), after: "RailsAdmin.config do |config|\n"
    end
  end



end
