class Review < ActiveRecord::Base
  include ApplicationHelper
  dragonfly_accessor :image

  has_ancestry

  paginates_per 10

  default_scope { order('sort') }
  scope :main, ->{ where(show_on_main: true) }
end

# == Schema Information
#
# Table name: reviews
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  desc         :text
#  short_text   :text
#  text         :text
#  show_on_main :boolean
#  sort         :integer
#  ancestry     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  image_uid    :string(255)
#
# Indexes
#
#  index_reviews_on_ancestry  (ancestry)
#
