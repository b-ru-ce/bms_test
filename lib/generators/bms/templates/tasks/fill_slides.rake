namespace :db do

  desc "Fill model Slide"
  task :fill_slides => :environment do

    require 'populator'
    require 'faker'

    Slide.destroy_all
    3.times do
      slide = Slide.new title: Populator.words(1..3).titleize, text: Populator.sentences(1..3), url: '/', image: File.new('vendor/bms/images/slider.jpg')
      slide.save(:validate => false)
    end

  end
end