# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  include PathWithAlias

  dragonfly_accessor :image

  validates :title, :presence => true
  validates :date, :presence => true

  paginates_per 10

  default_scope {order('date DESC')}
  scope :last_news, ->{ limit(2) }

end
