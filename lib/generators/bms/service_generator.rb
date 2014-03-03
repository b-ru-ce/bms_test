require 'rails/generators'

module Bms
  class ServiceGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def service
      generate 'controller', 'Services'
      copy_file 'app/controllers/services_controller.rb', 'app/controllers/services_controller.rb', force: true
      copy_file 'app/helpers/services_helper.rb', 'app/helpers/services_helper.rb', force: true
      run('rm app/assets/javascripts/services.js.coffee')
      run('rm app/assets/stylesheets/services.css.scss')
      route "get 'services' => 'services#index'"
      route "get '/services/:id-:alias' => 'services#show', as: 'service'"

      generate 'model', 'Service title:string image_uid:string short_text:text text:text sort:integer ancestry:string title_of_window:string meta:text'
      copy_file 'db/migrate/add_ancestry_to_services.rb', "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S").to_i + 1}_add_ancestry_to_services.rb"
      rake 'db:migrate'
      copy_file 'app/models/service.rb', 'app/models/service.rb', force: true

      copy_file 'app/views/services/index.html.haml', 'app/views/services/index.html.haml'
      copy_file 'app/views/services/show.html.haml', 'app/views/services/show.html.haml'
      copy_file 'app/views/services/_service.html.haml', 'app/views/services/_service.html.haml'

      copy_file 'app/assets/images/files/service.jpg', 'vendor/bms/images/service.jpg'
      copy_file 'tasks/fill_service.rake', 'lib/tasks/fill_service.rake'
      rake 'db:fill_service'
      run('rm lib/tasks/fill_service.rake')

      copy_file 'config/initializers/_rails_admin_service.rb', 'vendor/bms/initializers/_rails_admin_service.rb'
      inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_service.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"
    end



  end

end
