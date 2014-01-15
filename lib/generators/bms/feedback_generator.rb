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
      inject_into_file 'app/assets/javascripts/app.js.coffee', 'feedback()', after: "ready = ->\n"

      copy_file 'app/mailers/my_mailer.rb', 'app/mailers/my_mailer.rb'
      copy_file 'app/views/my_mailer/feedback.html.haml', 'app/views/my_mailer/feedback.html.haml'

      application(nil, env: "development") do
        "config.action_mailer.delivery_method = :smtp"
        "config.action_mailer.smtp_settings = {"
            ":address => 'smtp.yandex.ru',"
            ":port => 25,"
            ":authentication => :login, "
            ":user_name => 'no-reply@buzuluk.bz',"
            ":password => 'L3W00i9v'"
        "}"
      end

      application(nil, env: "production") do
        "config.action_mailer.delivery_method = :smtp"
        "config.action_mailer.smtp_settings = {"
            ":address => 'smtp.yandex.ru',"
            ":port => 25,"
            ":authentication => :login, "
            ":user_name => 'no-reply@buzuluk.bz',"
            ":password => 'L3W00i9v'"
        "}"
      end

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
