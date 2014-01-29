# -*- encoding : utf-8 -*-
class PortfolioObject < ActiveRecord::Base
  include PathWithAlias
  has_ancestry

  dragonfly_accessor :image

  validates :title, :presence => true

  paginates_per 10

  default_scope {order('sort')}
end

# == Schema Information
#
# Table name: portfolio_objects
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  image_uid       :string(255)
#  short_text      :text
#  text            :text
#  sort            :integer
#  ancestry        :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  title_of_window :string(255)
#  meta            :text
#
# Indexes
#
#  index_portfolio_objects_on_ancestry  (ancestry)
#
