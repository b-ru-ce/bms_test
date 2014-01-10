class InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(path)
    unless @prev_migration_nr
      @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    else
      @prev_migration_nr += 1
    end
    @prev_migration_nr.to_s
  end


  def base_prepare
    generate 'model', 'Page title:string text:text purpose:string show_in_menu:boolean menu:string meta:text title_of_window:string ancestry:string sort:integer'
    copy_file 'db/migrate/add_ancestry_to_page.rb', "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 1}_add_ancestry_to_page.rb"
    #migration_template 'db/migrate/add_ancestry_to_page.rb', 'db/migrate/add_ancestry_to_page.rb'
    #generate 'migration', 'AddIndexPagesOnAncestry'
    #inject_into_file 'db/migrate/*add_index_pages_on_ancestry.rb', 'add_index :pages, :ancestry', after: "def change\n"
    rake 'db:migrate'

    ##git :init
    ##git add: '.'
    ##git commit: '-m Init commit'
    #
    #gem 'haml-rails'
    #gem 'html2haml'
    #gem 'rails_admin'
    #gem 'cancan'
    #run('bundle install')
    #
    #generate 'rails_admin:install'
    #rake 'db:migrate'
    #
    #gem 'dragonfly', '~> 1.0.0'
    #gem 'ckeditor'
    #run('bundle install')
    #
    #generate 'dragonfly'
    #gem 'paperclip'
    #run('bundle install')
    #
    #generate 'ckeditor:install', '--orm=active_record --backend=paperclip'
    #rake 'db:migrate'
    #
    #generate 'cancan:ability'
    #
    #gem_group :development do
    #  gem 'annotate'
    #  gem 'populator'
    #  gem 'faker'
    #end
    #run('bundle install')
    #generate 'annotate:install'
    #gsub_file 'lib/tasks/auto_annotate_models.rake', 'before', 'after'
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
    #copy_file 'app/models/ability.rb', 'app/models/ability.rb', force: true
    #copy_file 'app/models/my_config.rb', 'app/models/my_config.rb', force: true
    #copy_file 'app/models/role.rb', 'app/models/role.rb', force: true
    #copy_file 'app/models/user.rb', 'app/models/user.rb', force: true
    #
    #copy_file 'tasks/base_fill.rake', 'lib/tasks/base_fill.rake'
    #rake 'db:fill_my_config'
    #rake 'db:fill_users'
    #
    #copy_file 'config/initializers/rails_admin.rb', 'config/initializers/rails_admin.rb', force: true
    #copy_file 'config/initializers/string.rb', 'config/initializers/string.rb'
    #copy_file 'config/locales/ru.yml', 'config/locales/ru.yml'
    #copy_file 'config/locales/devise.ru.yml', 'config/locales/devise.ru.yml'
    #copy_file 'config/locales/rails_admin.ru.yml', 'config/locales/rails_admin.ru.yml'
    #copy_file 'config/locales/kaminary.yml', 'config/locales/kaminary.yml'
    #copy_file 'app/controllers/application_controller.rb', 'app/controllers/application_controller.rb', force: true
    #copy_file 'app/helpers/application_helper.rb', 'app/helpers/application_helper.rb', force: true
    #
    #application do
    #  "config.time_zone = 'Ekaterinburg'"
    #  "config.i18n.default_locale = :ru"
    #end
    #
    ##git add: '.'
    ##git commit: '-m Base prepare completed'

  end

  #def pages
  #  gem 'ancestry'
  #  gem 'rails_admin_nestable'
  #  run('bundle install')
  #
  #  generate 'controller', 'Pages'
  #  copy_file 'app/controllers/pages_controller.rb', 'app/controllers/pages_controller.rb', force: true
  #
  #  generate 'model', 'Page title:string text:text purpose:string show_in_menu:boolean menu:string meta:text title_of_window:string ancestry:string sort:integer'
  #  migration_template 'db/migrate/add_ancestry_to_page', 'db/migrate/add_ancestry_to_page'
  #  #generate 'migration', 'AddIndexPagesOnAncestry'
  #  #inject_into_file 'db/migrate/*add_index_pages_on_ancestry.rb', 'add_index :pages, :ancestry', after: "def change\n"
  #  rake 'db:migrate'
  #  copy_file 'app/models/page.rb', 'app/models/page.rb', force: true
  #
  #  copy_file 'app/views/layouts/application.html.haml', 'app/views/layouts/application.html.haml'
  #  run('rm app/views/layouts/application.html.erb')
  #  copy_file 'app/views/layouts/menu/_menu.html.haml', 'app/views/layouts/menu/_menu.html.haml'
  #  copy_file 'app/views/layouts/menu/_menu_wrapper.html.haml', 'app/views/layouts/menu/_menu_wrapper.html.haml'
  #  copy_file 'app/views/pages/home.html.haml', 'app/views/pages/home.html.haml'
  #  copy_file 'app/views/pages/show.html.haml', 'app/views/pages/show.html.haml'
  #
  #  #copy_file 'config/initializers/_rails_admin_pages.rb', 'vendor/bms/initializers/_rails_admin_pages.rb'
  #  #inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_pages.rb'), after: "RailsAdmin.config do |config|\n"
  #
  #  route "root 'pages#home'"
  #  route "get '/pages/:id-:alias' => 'pages#show', as: 'page'"
  #
  #  copy_file 'tasks/fill_pages.rake', 'lib/tasks/fill_pages.rake'
  #  rake 'db:fill_pages'
  #end
  #
  #def news
  #  if yes?('Would you like to install module News? (y/n)')
  #    generate 'controller', 'Articles'
  #    copy_file 'app/controllers/articles_controller.rb', 'app/controllers/articles_controller.rb', force: true
  #
  #    generate 'model', 'Article title:text date:date image_uid:string short_text:text text:text title_of_window:string meta:text'
  #    rake 'db:migrate'
  #    copy_file 'app/models/article.rb', 'app/models/article.rb', force: true
  #
  #    copy_file 'app/views/articles/_article.html.haml', 'app/views/articles/_article.html.haml'
  #    copy_file 'app/views/articles/index.html.haml', 'app/views/articles/index.html.haml'
  #    copy_file 'app/views/articles/show.html.haml', 'app/views/articles/show.html.haml'
  #    route "get 'news' => 'articles#index'"
  #    route "get 'news/:id-:alias' => 'articles#show'"
  #
  #    copy_file 'tasks/fill_news.rake', 'lib/tasks/fill_news.rake'
  #    rake 'db:fill_news'
  #
  #    #copy_file 'config/initializers/_rails_admin_news.rb', 'vendor/bms/initializers/_rails_admin_news.rb'
  #    #inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_news.rb'), after: "RailsAdmin.config do |config|\n"
  #  end
  #end



end
