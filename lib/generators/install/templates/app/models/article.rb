# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  include ApplicationHelper

  dragonfly_accessor :image

  validates :title, :presence => true
  validates :date, :presence => true

  paginates_per 10

  default_scope {order('date DESC')}
  scope :last_news, ->{ limit(2) }

  def to_param
    '/news/' + id.to_s + '-' + title.transliterate
  end

  def html_title
    (title_of_window and !title_of_window.strip.blank?) ?
        title_of_window : (MyConfig.get_config 'default_title' + ' - ' + self.title)
  end

end
