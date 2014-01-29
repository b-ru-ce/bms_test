# -*- encoding : utf-8 -*-
class Service < ActiveRecord::Base
  include PathWithAlias
  has_ancestry

  dragonfly_accessor :image

  validates :title, :presence => true

  paginates_per 10

  default_scope {order('sort')}
end

# == Schema Information
#
# Table name: services
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
#  index_services_on_ancestry  (ancestry)
#
