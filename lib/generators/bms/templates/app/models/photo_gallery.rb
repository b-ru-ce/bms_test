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

  def html_title
    title_of_window.to_s.strip.blank? ? (MyConfig.get_config('default_title') + ' - ' + title) : title_of_window
  end
end

# == Schema Information
#
# Table name: photo_galleries
#
#  id              :integer          not null, primary key
#  title           :text
#  sort            :integer
#  ancestry        :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  title_of_window :string(255)
#
# Indexes
#
#  index_photo_galleries_on_ancestry  (ancestry)
#
