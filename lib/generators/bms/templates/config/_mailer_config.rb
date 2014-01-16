
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address => "smtp.yandex.ru",
      :port => 25,
      :authentication => :login, #или :plain
      :user_name => "no-reply@buzuluk.bz",
      :password => "L3W00i9v"
  }
