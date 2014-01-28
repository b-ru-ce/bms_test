require 'rails/generators'

module Bms
  class FeedbackGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def feedback
      generate 'controller', 'Feedbacks'
      copy_file 'app/controllers/feedbacks_controller.rb', 'app/controllers/feedbacks_controller.rb', force: true
      run('rm app/assets/javascripts/feedbacks.js.coffee')
      run('rm app/assets/stylesheets/feedbacks.css.scss')
      route "get 'contacts' => 'feedbacks#new'"

      copy_file 'app/assets/javascripts/feedback.js.coffee'
      inject_into_file 'app/assets/javascripts/app.js.coffee', "  feedback()\n", after: "ready = ->\n"
      inject_into_file 'app/views/layouts/application.html.erb', "\n  <%= render 'layouts/dialogs' %>\n", before: '</body>'
      copy_file 'app/views/layouts/_dialogs.html.haml', 'app/views/layouts/_dialogs.html.haml'

      copy_file 'app/mailers/my_mailer.rb', 'app/mailers/my_mailer.rb'
      copy_file 'app/views/my_mailer/feedback.html.haml', 'app/views/my_mailer/feedback.html.haml'

      copy_file 'config/_mailer_config.rb', 'vendor/bms/initializers/_mailer_config.rb'
      application File.read('vendor/bms/initializers/_mailer_config.rb'), env: "development"
      application File.read('vendor/bms/initializers/_mailer_config.rb'), env: "production"

      generate 'model', 'Feedback name:text phone:text email:text theme:text text:text'
      rake 'db:migrate'
      copy_file 'app/models/feedback.rb', 'app/models/feedback.rb', force: true
      route "resources :feedbacks"

      copy_file 'app/views/feedbacks/new.html.haml', 'app/views/feedbacks/new.html.haml'

      copy_file 'tasks/fill_feedback.rake', 'lib/tasks/fill_feedback.rake'
      rake 'db:fill_feedback'

      copy_file 'config/initializers/_rails_admin_feedback.rb', 'vendor/bms/initializers/_rails_admin_feedback.rb'
      inject_into_file 'config/initializers/rails_admin.rb', File.read('vendor/bms/initializers/_rails_admin_feedback.rb').force_encoding('ASCII-8BIT'), after: "RailsAdmin.config do |config|\n"
    end



  end

end
