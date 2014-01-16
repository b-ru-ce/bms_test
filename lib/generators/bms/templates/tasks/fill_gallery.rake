namespace :db do

  desc 'Fill model PhotoGallery and Photo'
  task :fill_gallery => :environment do

    require 'populator'
    require 'faker'

    page = Page.purpose('/gallery').first || Page.find_by_title('Галерея')
    if page
      page.update_attributes(purpose: '/gallery')
    else Page.create!(title: 'Галерея', text: '', show_in_menu: true, sort: 4, purpose: '/gallery' )
    end

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