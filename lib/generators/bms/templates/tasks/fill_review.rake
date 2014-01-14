namespace :db do

  desc "Fill model Review"
  task :fill_review => :environment do

    require 'populator'
    require 'faker'

    page_reviews = Page.purpose('/reviews').first
    unless page_reviews.nil?
      page_reviews.delete
    end
    Page.create!(title: 'Отзывы', text: '', show_in_menu: true, sort: 3, purpose: '/reviews' )

    Review.destroy_all
    10.times do |i|
      review = Review.new name: Faker::Name.name, desc: Populator.words(3..5), short_text: Populator.sentences(2..3),
                          text: Populator.sentences(10), show_on_main: i > 4, image: File.new('vendor/bms/images/review.jpg')
      review.save(:validate => false)
    end

  end
end