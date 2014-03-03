require 'rails/generators'

module Bms
  class GalleryGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def gallery
      generate 'controller', 'PhotoGalleries'
      copy_file 'app/controllers/photo_galleries_controller.rb', 'app/controllers/photo_galleries_controller.rb', force: true
      copy_file 'app/helpers/photo_galleries_helper.rb', 'app/helpers/photo_galleries_helper.rb', force: true
      run('rm app/assets/javascripts/photo_galleries.js.coffee')
      run('rm app/assets/stylesheets/photo_galleries.css.scss')
      route "get 'gallery' => 'photo_galleries#index'"
      route "get '/galleries/:id-:alias' => 'photo_galleries#show', as: 'photo_gallery'"

      generate 'model', 'PhotoGallery title:text sort:integer ancestry:string title_of_window:string meta:text'
      generate 'model', 'Photo photo_gallery_id:integer image_uid:string description:text sort:integer ancestry:string main:boolean'
      copy_file 'db/migrate/add_ancestry_to_photos.rb', "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S").to_i + 1}_add_ancestry_to_photos.rb"
      rake 'db:migrate'
      copy_file 'app/models/photo.rb', 'app/models/photo.rb', force: true
      copy_file 'app/models/photo_gallery.rb', 'app/models/photo_gallery.rb', force: true

      copy_file 'app/views/photo_galleries/index.html.haml', 'app/views/photo_galleries/index.html.haml'
      copy_file 'app/views/photo_galleries/show.html.haml', 'app/views/photo_galleries/show.html.haml'

      copy_file 'app/assets/images/files/gallery.jpg', 'vendor/bms/images/gallery.jpg'
      copy_file 'tasks/fill_gallery.rake', 'lib/tasks/fill_gallery.rake'
      rake 'db:fill_gallery'
      run('rm lib/tasks/fill_gallery.rake')

      copy_file 'config/initializers/_rails_admin_gallery.rb', 'vendor/bms/initializers/_rails_admin_gallery.rb'
      inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_gallery.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"
    end



  end

end
