require 'rails/generators'

module Bms
  class PortfolioGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def portfolio
      generate 'controller', 'PortfolioObjects'
      copy_file 'app/controllers/portfolio_objects_controller.rb', 'app/controllers/portfolio_objects_controller.rb', force: true
      copy_file 'app/helpers/portfolio_objects_helper.rb', 'app/helpers/portfolio_objects_helper.rb', force: true
      run('rm app/assets/javascripts/portfolio_objects.js.coffee')
      run('rm app/assets/stylesheets/portfolio_objects.css.scss')
      route "get 'portfolio' => 'portfolio_objects#index'"
      route "get '/portfolio/:id-:alias' => 'portfolio_objects#show', as: 'portfolio_object'"

      generate 'model', 'PortfolioObject title:string image_uid:string short_text:text text:text sort:integer ancestry:string title_of_window:string meta:text'
      copy_file 'db/migrate/add_ancestry_to_portfolio.rb', "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S").to_i + 1}_add_ancestry_to_portfolio.rb"
      rake 'db:migrate'
      copy_file 'app/models/portfolio_object.rb', 'app/models/portfolio_object.rb', force: true

      copy_file 'app/views/portfolio_objects/index.html.haml', 'app/views/portfolio_objects/index.html.haml'
      copy_file 'app/views/portfolio_objects/show.html.haml', 'app/views/portfolio_objects/show.html.haml'
      copy_file 'app/views/portfolio_objects/_portfolio_object.html.haml', 'app/views/portfolio_objects/_portfolio_object.html.haml'

      copy_file 'app/assets/images/files/portfolio.jpg', 'vendor/bms/images/portfolio.jpg'
      copy_file 'tasks/fill_portfolio.rake', 'lib/tasks/fill_portfolio.rake'
      rake 'db:fill_portfolio'
      run('rm lib/tasks/fill_portfolio.rake')

      copy_file 'config/initializers/_rails_admin_portfolio_object.rb', 'vendor/bms/initializers/_rails_admin_portfolio_object.rb'
      inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_portfolio_object.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"
    end



  end

end
