# -*- encoding : utf-8 -*-
class MyMailer < ActionMailer::Base
  default from: 'no-reply@buzuluk.bz'

  def feedback(f)
    @f = f
    mail(:to => MyConfig.get_config('email'), :subject => 'Обратная связь')
  end
end
