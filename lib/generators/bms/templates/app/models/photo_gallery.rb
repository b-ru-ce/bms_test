# -*- encoding : utf-8 -*-
class PhotoGallery < ActiveRecord::Base
  include PathWithAlias

  has_ancestry

  validates :title, presence: true

  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true

  default_scope { order('sort') }

  def main_photo
    photos.main.first || photos.first
  end
end
