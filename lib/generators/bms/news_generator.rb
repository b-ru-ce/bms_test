require 'rails/generators'

module Bms
  class NewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def news
      generate 'controller', 'Articles'
      copy_file 'app/controllers/articles_controller.rb', 'app/controllers/articles_controller.rb', force: true
      run('rm app/assets/javascripts/articles.js.coffee')
      run('rm app/assets/stylesheets/articles.css.scss')

      generate 'model', 'Article title:text date:date image_uid:string short_text:text text:text title_of_window:string meta:text'
      rake 'db:migrate'
      copy_file 'app/models/article.rb', 'app/models/article.rb', force: true

      copy_file 'app/views/articles/_article.html.haml', 'app/views/articles/_article.html.haml'
      copy_file 'app/views/articles/index.html.haml', 'app/views/articles/index.html.haml'
      copy_file 'app/views/articles/show.html.haml', 'app/views/articles/show.html.haml'
      append_file 'app/views/pages/home.html.haml', "= render partial: 'articles/article', collection: Article.last_news\n= link_to 'Все новости', '/news'".force_encoding('ASCII-8BIT')

      route "get 'news' => 'articles#index'"
      route "get '/news/:id-:alias' => 'articles#show', as: 'article'"

      copy_file 'app/assets/images/files/news.jpg', 'vendor/bms/images/news.jpg'
      copy_file 'tasks/fill_news.rake', 'lib/tasks/fill_news.rake'
      rake 'db:fill_news'

      copy_file 'config/initializers/_rails_admin_news.rb', 'vendor/bms/initializers/_rails_admin_news.rb'
      inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_news.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"
    end



  end

end
