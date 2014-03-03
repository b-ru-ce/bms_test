# -*- encoding : utf-8 -*-
class Photo < ActiveRecord::Base
  include ApplicationHelper
  dragonfly_accessor :image

  has_ancestry

  validates :image_uid, presence: true

  belongs_to :photo_gallery

  default_scope { order('sort') }
  scope :main, ->{ where(main: true).limit(1) }
end

# == Schema Information
#
# Table name: photos
#
#  id               :integer          not null, primary key
#  photo_gallery_id :integer
#  image_uid        :string(255)
#  description      :text
#  sort             :integer
#  ancestry         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  main             :boolean
#
# Indexes
#
#  index_photos_on_ancestry  (ancestry)
#
