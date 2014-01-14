class Slide < ActiveRecord::Base
  include ApplicationHelper
  dragonfly_accessor :image

  has_ancestry

  validates :title, presence:  true
  validates :image_uid, presence: true

  default_scope { order('sort') }
  scope :last, limit(3)
end

# == Schema Information
#
# Table name: slides
#
#  id         :integer          not null, primary key
#  title      :text
#  image_uid  :string(255)
#  text       :text
#  url        :string(255)
#  sort       :integer
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_slides_on_ancestry  (ancestry)
#
