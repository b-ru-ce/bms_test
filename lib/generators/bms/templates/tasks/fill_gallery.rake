namespace :db do

  desc 'Fill model PhotoGallery and Photo'
  task :fill_gallery => :environment do

    require 'populator'
    require 'faker'

    page_gallery = Page.purpose('/gallery').first
    unless page_gallery.nil?
      page_gallery.delete
    end
    Page.create!(title: 'Галерея', text: '', show_in_menu: true, sort: 4, purpose: '/gallery' )

    PhotoGallery.destroy_all

    3.times do |i|
      gallery = PhotoGallery.create title: Populator.words(3..5).titleize
      5.times do |j|
        photo = gallery.photos.build image: File.new('vendor/bms/images/gallery.jpg'), description: Populator.sentences(1), main: j == 3
        photo.save(validate: false)
      end
    end

  end
end