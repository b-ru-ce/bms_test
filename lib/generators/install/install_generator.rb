class NewsGenerator < Rails::Generators::Base
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

    gem_group :development do
      gem 'annotate'
      gem 'populator'
      gem 'faker'
    end
    run('bundle install')
    generate 'annotate:install'
    gsub_file 'lib/tasks/auto_annotate_models.rake', 'before', 'after'

    generate 'kaminari:views', 'default'
    generate 'devise:views'

    run('for file in app/views/devise/**/*.erb; do html2haml -e $file ${file%erb}haml && rm $file; done')

    generate 'model', 'MyConfig key:string key_ru:string value:text'
    generate 'model', 'Role name:string'
    generate 'migration', 'AddRoleIdToUsers role_id:integer'
    rake 'db:migrate'

    copy_file 'app/models/ability.rb', 'app/models/ability.rb', force: true
    copy_file 'app/models/my_config.rb', 'app/models/my_config.rb', force: true
    copy_file 'app/models/role.rb', 'app/models/role.rb', force: true
    copy_file 'app/models/user.rb', 'app/models/user.rb', force: true

    copy_file 'tasks/base_fill.rake', 'lib/tasks/base_fill.rake'
    rake 'db:fill_my_config'
    rake 'db:fill_users'

    copy_file 'config/initializers/rails_admin.rb', 'config/initializers/rails_admin.rb', force: true
    copy_file 'config/initializers/string.rb', 'config/initializers/string.rb'
    copy_file 'config/locales/ru.yml', 'config/locales/ru.yml'
    copy_file 'config/locales/devise.ru.yml', 'config/locales/devise.ru.yml'
    copy_file 'config/locales/rails_admin.ru.yml', 'config/locales/rails_admin.ru.yml'
    copy_file 'config/locales/kaminary.yml', 'config/locales/kaminary.yml'
    copy_file 'app/controllers/application_controller.rb', 'app/controllers/application_controller.rb', force: true
    copy_file 'app/helpers/application_helper.rb', 'app/helpers/application_helper.rb', force: true

    application do
      "config.time_zone = 'Ekaterinburg'"
      "config.i18n.default_locale = :ru"
    end

    #git add: '.'
    #git commit: '-m Base prepare completed'

  end

  def pages
    gem 'ancestry'
    gem 'rails_admin_nestable'
    run('bundle install')

    generate 'controller', 'Pages'
    copy_file 'app/controllers/pages_controller.rb', 'app/controllers/pages_controller.rb', force: true

    generate 'model', 'Page title:string text:text purpose:string show_in_menu:boolean menu:string meta:text title_of_window:string ancestry:string sort:integer'
    copy_file 'db/migrate/add_ancestry_to_page.rb', "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S").to_i + 1}_add_ancestry_to_page.rb"
    rake 'db:migrate'
    copy_file 'app/models/page.rb', 'app/models/page.rb', force: true

    copy_file 'app/views/layouts/application.html.haml', 'app/views/layouts/application.html.haml'
    run('rm app/views/layouts/application.html.erb')
    copy_file 'app/views/layouts/menu/_menu.html.haml', 'app/views/layouts/menu/_menu.html.haml'
    copy_file 'app/views/layouts/menu/_menu_wrapper.html.haml', 'app/views/layouts/menu/_menu_wrapper.html.haml'
    copy_file 'app/views/pages/home.html.haml', 'app/views/pages/home.html.haml'
    copy_file 'app/views/pages/show.html.haml', 'app/views/pages/show.html.haml'

    copy_file 'config/initializers/_rails_admin_pages.rb', 'vendor/bms/initializers/_rails_admin_pages.rb'
    inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_pages.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"

    route "root 'pages#home'"
    route "get '/pages/:id-:alias' => 'pages#show', as: 'page'"

    copy_file 'tasks/fill_pages.rake', 'lib/tasks/fill_pages.rake'
    rake 'db:fill_pages'
  end

  def other_modules
    generate 'news' if yes?('Would you like to install module News? (y/n)')
  end

end
