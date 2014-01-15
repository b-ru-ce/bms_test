require 'rails/generators'

module Bms
  class ReviewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def reviews
      generate 'controller', 'Reviews'
      copy_file 'app/controllers/reviews_controller.rb', 'app/controllers/reviews_controller.rb', force: true
      run('rm app/assets/javascripts/reviews.js.coffee')
      run('rm app/assets/stylesheets/reviews.css.scss')
      route "get 'reviews' => 'reviews#index'"

      generate 'model', 'Review name:string desc:text short_text:text text:text image_uid:string show_on_main:boolean sort:integer ancestry:string'
      copy_file 'db/migrate/add_ancestry_to_reviews.rb', "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S").to_i + 1}_add_ancestry_to_reviews.rb"
      rake 'db:migrate'
      copy_file 'app/models/review.rb', 'app/models/review.rb', force: true

      copy_file 'app/views/layouts/_review.html.haml', 'app/views/layouts/_review.html.haml'
      copy_file 'app/views/reviews/_review.html.haml', 'app/views/reviews/_review.html.haml'
      copy_file 'app/views/reviews/index.html.haml', 'app/views/reviews/index.html.haml'
      append_file 'app/views/pages/home.html.haml', "\n%ul= render partial: 'layouts/review', collection: Review.main\n= link_to 'Все отзывы', '/reviews'".force_encoding('ASCII-8BIT')

      copy_file 'app/assets/images/files/review.jpg', 'vendor/bms/images/review.jpg'
      copy_file 'tasks/fill_review.rake', 'lib/tasks/fill_review.rake'
      rake 'db:fill_review'

      copy_file 'config/initializers/_rails_admin_reviews.rb', 'vendor/bms/initializers/_rails_admin_reviews.rb'
      inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_reviews.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"
    end



  end

end
