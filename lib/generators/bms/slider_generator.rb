require 'rails/generators'

module Bms
  class SliderGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def slider
      generate 'model', 'Slide title:text image_uid:string text:text url:string sort:integer ancestry:string'
      copy_file 'db/migrate/add_ancestry_to_slides.rb', "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S").to_i + 1}_add_ancestry_to_slides.rb"
      rake 'db:migrate'
      copy_file 'app/models/slide.rb', 'app/models/slide.rb', force: true

      copy_file 'app/views/layouts/_slide.html.haml', 'app/views/layouts/_slide.html.haml'
      append_file 'app/views/pages/home.html.haml', "\n%ul= render partial: 'layouts/slide', collection: Slide.last"

      copy_file 'app/assets/images/files/slider.jpg', 'vendor/bms/images/slider.jpg'
      copy_file 'tasks/fill_slides.rake', 'lib/tasks/fill_slides.rake'
      rake 'db:fill_slides'

      copy_file 'config/initializers/_rails_admin_slides.rb', 'vendor/bms/initializers/_rails_admin_slides.rb'
      inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_slides.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"
    end



  end

end
