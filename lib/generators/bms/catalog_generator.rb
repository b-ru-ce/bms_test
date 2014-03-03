require 'rails/generators'

module Bms
  class CatalogGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def catalog
      generate 'model', 'Category title:string meta:text title_of_window:string ancestry:string sort:integer'
      generate 'model', 'Product category_id:integer title:string image_uid:string price:integer text:text sort:integer ancestry:string meta:text title_of_window:string'
      copy_file 'db/migrate/add_ancestry_to_catalog.rb', "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S").to_i + 1}_add_ancestry_to_catalog.rb"
      copy_file 'app/models/category.rb', 'app/models/category.rb', force: true
      copy_file 'app/models/product.rb', 'app/models/product.rb', force: true
      rake 'db:migrate'

      generate 'controller', 'Catalog'
      copy_file 'app/controllers/catalog_controller.rb', 'app/controllers/catalog_controller.rb', force: true
      copy_file 'app/helpers/catalog_helper.rb', 'app/helpers/catalog_helper.rb', force: true
      run('rm app/assets/stylesheets/catalog.css.scss')
      route "get '/catalog/:category_alias/:id-:alias' => 'catalog#show_product', as: 'product'"
      route "get '/catalog/:id-:alias' => 'catalog#show_category', as: 'category'"
      route "get '/catalog' => 'catalog#index'"

      copy_file 'app/assets/javascripts/catalog.js.coffee', force: true
      inject_into_file 'app/assets/javascripts/application.js', "\n//= require catalog", before: "\n//= require app"
      inject_into_file 'app/assets/javascripts/app.js.coffee', "  catalog()\n", after: "ready = ->\n"

      copy_file 'app/views/catalog/_category.html.haml', 'app/views/catalog/_category.html.haml'
      copy_file 'app/views/catalog/index.html.haml', 'app/views/catalog/index.html.haml'
      copy_file 'app/views/catalog/show_category.html.haml', 'app/views/catalog/show_category.html.haml'
      copy_file 'app/views/catalog/show_product.html.haml', 'app/views/catalog/show_product.html.haml'

      copy_file 'app/assets/images/files/catalog.jpg', 'vendor/bms/images/catalog.jpg'
      copy_file 'tasks/fill_catalog.rake', 'lib/tasks/fill_catalog.rake'
      rake 'db:fill_catalog'
      run('rm lib/tasks/fill_catalog.rake')

      copy_file 'config/initializers/_rails_admin_catalog.rb', 'vendor/bms/initializers/_rails_admin_catalog.rb'
      inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_catalog.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"
    end



  end

end
