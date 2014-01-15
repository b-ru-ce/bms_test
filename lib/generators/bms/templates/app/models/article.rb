# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  include PathWithAlias

  dragonfly_accessor :image


  validates :title, :presence => true
  validates :date, :presence => true

  paginates_per 10

  default_scope {order('date DESC')}
  scope :last_news, ->{ limit(2) }

  def html_title
    title_of_window.to_s.strip.blank? ? (MyConfig.get_config('default_title') + ' - ' + title) : title_of_window
  end

end

# == Schema Information
#
# Table name: articles
#
#  id              :integer          not null, primary key
#  title           :text
#  date            :date
#  short_text      :text
#  text            :text
#  title_of_window :string(255)      default("")
#  created_at      :datetime
#  updated_at      :datetime
#  image_uid       :string(255)
#
